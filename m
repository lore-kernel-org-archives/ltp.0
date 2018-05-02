From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Wed, 2 May 2018 16:22:14 +0200
Subject: [LTP] runltp - error when using another tmp folder
Message-ID: <20180502162214.5d962173@dell-desktop.home>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hello everyone,

While testing some syscalls tests on an embedded device, I got an error
on many tests (running as "root" user).

Here is an output for chmod03 test:

tst_tmpdir: mkdtemp(/home/root/ltp-XXXXAeI13S/utirN7h1b) failed:
errno=EACCES(13): Permission denied

After looking at the code, Thomas (in CC) and myself found that the
"temp" folder that we used (with "-d" option on "runltp") does not have
a permission of 777.
According to the code of runltp, it seems that it creates a folder with
this permission but because it is retrieving the option using
"readlink", if the folder is not available, it leads to an error
because TMPBASE variable is empty:

BusyBox v1.24.1 (2018-02-10 17:35:25 CET) multi-call binary.

Usage: mkdir [OPTIONS] DIRECTORY...
FATAL: Unable to make temporary directory


Currently, we fixed the issue by using a /tmp folder that already has
777 permission (default's one) but maybe, other users may want to use
another folder and may have the same error we got.

Let me know if you have ideas on how we could improve it.
Thank you in advance.

Best regards,

Mylène

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
