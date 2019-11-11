From: Yu <999iscool@gmail.com>
Date: Sun, 10 Nov 2019 19:34:30 -0500
Subject: [LTP] Verify LTP was compiled with specific kernel headers
Message-ID: <CALgnY2eHDnkoYLoC5TdFzecjpUb2AAJRadU30LofZxT2QG-fgg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

Not sure if this is the right place to ask, but I am trying to compile LTP
with a specific kernel release. The source tarball was extracted. I make
install the linux kernel headers:

make headers_install INSTALL_HDR_PATH=/tmp/test-kernel-h

Then I proceeded with:

make autotool
./configure --prefix=/tmp/out --includedir=/tmp/kernel-h/include/linux
make
make install

My question is how can I tell if it's really compiled with those headers?
Is includedir the right one to use? I see oldincludedir is defaults to
/usr/include.

ver_linux script looks at /etc/*release file.

Thanks

YW
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191110/d2bcaf31/attachment.htm>
