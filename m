From: Akshatha Gangadharaiah <agangadh@eng.ucsd.edu>
Date: Fri, 27 Jan 2017 01:38:03 -0800
Subject: [LTP] Running LTP on new filesystems
Message-ID: <A8370F49-367D-4A04-BC93-A485ECFA42F7@eng.ucsd.edu>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hi everyone,

I am trying to run LTP on a new filesystem and am stuck in figuring out the=
 right way to do this.

Specifically, if I have mounted my file system at /mnt/new-fs, I want to us=
e this directory as mount point for all the filesystem tests.
I tried running by specifying this as the  -d TMPDIR  option ( -d /mnt/new-=
fs in runltp ) but I am not sure if this is the right way.

I don=E2=80=99t see any specific instructions on how to run LTP on new file=
systems.
It will be a great help if someone points out the right way to do this or a=
ny documentation that might help.

Thanks for your time and patience,

Regards,
Akshatha G


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170127/3427ad83/att=
achment.html>
