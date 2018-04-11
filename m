From: Li Wang <liwang@redhat.com>
Date: Wed, 11 Apr 2018 17:15:22 +0800
Subject: [LTP] [RFC PATCH] read_all: give more time to wait children
	finish read action
In-Reply-To: <87po38wsx5.fsf@rpws.prws.suse.cz>
References: <1523092180-5365-1-git-send-email-liwang@redhat.com>
 <87r2nox1s9.fsf@rpws.prws.suse.cz>
 <CAEemH2cSXtQfiM4snXAL-Eof7Xe3aY50z8ce=K4yo6=yBqtEbA@mail.gmail.com>
 <87po38wsx5.fsf@rpws.prws.suse.cz>
Message-ID: <CAEemH2d=O8Rm_Wf8+05oRe3CNjCr4MHRFMAoaLe=SUhfbd73Xg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Richard Palethorpe <rpalethorpe@suse.de> wrote:


> > You are right, I'm now still looking for a better way to avoid this blo=
ck
> > I/O issue.
>
> Maybe you could add a field to the worker struct containing the current
> file being read and a timestamp of when it started reading that
> file. Then we can use that information later to find out if a particular
> file is taking a long time to read.
>
>
=E2=80=8BI tried to count the reading time of files in children, it shows 0=
~200 ms
has been elapsed for each one.
But for parent, the most slower cost time of stop_worker() is 8ms, and even
visit_dir(root_dir)
push all of the files, it takes only 1000ms. That probably can prove that
why some
children stalled there.

=3D=3D=3D=3D=3D=3D=3D=3D
read_all.c:231: INFO:
read(/sys/kernel/debug/tracing/per_cpu/cpu11/snapshot_raw), elapsed_ms =3D
90: EAGAIN/EWOULDBLOCK
read_all.c:231: INFO:
read(/sys/kernel/debug/tracing/per_cpu/cpu10/trace_pipe), elapsed_ms =3D 0:
EAGAIN/EWOULDBLOCK
read_all.c:231: INFO:
read(/sys/kernel/debug/tracing/per_cpu/cpu12/trace_pipe), elapsed_ms =3D 11=
0:
EAGAIN/EWOULDBLOCK
...
read_all.c:231: INFO:
read(/sys/kernel/debug/tracing/per_cpu/cpu9/trace_pipe_raw), elapsed_ms =3D
160: EAGAIN/EWOULDBLOCK
...
read_all.c:231: INFO:
read(/sys/kernel/debug/tracing/per_cpu/cpu9/trace_pipe_raw), elapsed_ms =3D
180: EAGAIN/EWOULDBLOCK
read_all.c:231: INFO:
read(/sys/kernel/debug/tracing/per_cpu/cpu11/trace_pipe), elapsed_ms =3D 0:
EAGAIN/EWOULDBLOCK
...
read_all.c:231: INFO:
read(/sys/kernel/debug/tracing/per_cpu/cpu10/snapshot_raw), elapsed_ms =3D
130: EAGAIN/EWOULDBLOCK
read_all.c:231: INFO:
read(/sys/kernel/debug/tracing/per_cpu/cpu6/trace_pipe), elapsed_ms =3D 200:
EAGAIN/EWOULDBLOCK
read_all.c:231: INFO:
read(/sys/kernel/debug/tracing/per_cpu/cpu9/trace_pipe), elapsed_ms =3D 0:
EAGAIN/EWOULDBLOCK
read_all.c:231: INFO:
read(/sys/kernel/debug/tracing/per_cpu/cpu5/snapshot_raw), elapsed_ms =3D 0:
EAGAIN/EWOULDBLOCK




--=20
Li Wang
liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180411/ab351731/att=
achment.html>
