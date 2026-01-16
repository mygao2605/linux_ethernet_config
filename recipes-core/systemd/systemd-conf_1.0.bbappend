FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://10-static.network"

do_install:append() {
    # Sử dụng đường dẫn hệ thống chuẩn của Yocto
    # ${S} hoặc ${WORKDIR} thường là nơi chứa file sau khi fetch
    install -d ${D}${systemd_unitdir}/network/
    
    # Thử copy với kiểm tra trực tiếp trong thư mục WORKDIR
    if [ -f "${WORKDIR}/10-static.network" ]; then
        install -m 0644 ${WORKDIR}/10-static.network ${D}${systemd_unitdir}/network/
    else
        # Nếu không thấy ở WORKDIR, thử tìm trong thư mục hiện tại của task
        install -m 0644 ${S}/10-static.network ${D}${systemd_unitdir}/network/ || \
        bbfatal "Khong tim thay file 10-static.network de cai dat!"
    fi
}

FILES:${PN} += "${systemd_unitdir}/network/10-static.network"