Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1Q7jAE-0005X6-Lm
	for ltp-list@lists.sourceforge.net; Thu, 07 Apr 2011 06:57:58 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Q7jAD-0003zS-RL
	for ltp-list@lists.sourceforge.net; Thu, 07 Apr 2011 06:57:58 +0000
Received: by pwj9 with SMTP id 9so1282635pwj.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 06 Apr 2011 23:57:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110225103620.GA10350@hpt.nay.redhat.com>
References: <20110225103620.GA10350@hpt.nay.redhat.com>
Date: Wed, 6 Apr 2011 23:57:51 -0700
Message-ID: <BANLkTimC1VXcu1DTfR+nOK5sx5vvKguZkQ@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] thp testcase come from CVE reproducer
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>, ltp-list@lists.sourceforge.net

I'm going to be more anal retentive with this review than I was previously.

On Fri, Feb 25, 2011 at 2:36 AM, Han Pingtian <phan@redhat.com> wrote:
> This is a reproducer of =A0CVE-2011-0999, which fixed by mainline commit
> a7d6e4ecdb7648478ddec76d30d87d03d6e22b31:
>
> "Transparent hugepages can only be created if rmap is fully
> functional. So we must prevent hugepages to be created while
> is_vma_temporary_stack() is true."
>
> When running in a loop, it can trigger panic like this, if kernel
> unpatched:
>
> kernel BUG at mm/huge_memory.c:1260!
> invalid opcode: 0000 [#1] SMP
> last sysfs file: /sys/devices/system/cpu/cpu23/cache/index2/shared_cpu_map

...
>
> So I recommend to run it as 'thp01 -I xxx'.
> +static option_t options[] =3D {
> + =A0 =A0 =A0 {NULL, NULL, NULL}
> +};
> +
> +static void usage(void)
> +{
> + =A0 =A0return;
> +}
> +
> +int main(int argc, char **argv) {
> + =A0 =A0 =A0 int i, lc, st;
> + =A0 =A0 =A0 pid_t pid;
> + =A0 =A0 =A0 char *msg;
> + =A0 =A0 =A0 char *c[257];
> + =A0 =A0 =A0 char cc[32*4096];
> + =A0 =A0 =A0 struct rlimit rl =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .rlim_cur =3DRLIM_INFINITY,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .rlim_max=3DRLIM_INFINITY,
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 msg =3D parse_opts(argc, argv, options, usage);
> + =A0 =A0 =A0 if (msg !=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK, NULL, "OPTION PARSING ERROR=
 - %s", msg);
> +
> + =A0 =A0 =A0 for (lc =3D 0; TEST_LOOPING(lc); lc++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (pid =3D fork()) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case -1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TB=
ROK|TERRNO, NULL, "fork");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memset(cc, =
'c', 32*4096-1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i=3D0;=
i<256;i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 c[i] =3D cc;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (setrlim=
it(RLIMIT_STACK, &rl) =3D=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 tst_brkm(TBROK|TERRNO, NULL, "setrlimit");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (execve(=
"/bin/true", c, c) =3D=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 tst_brkm(TBROK|TERRNO, NULL, "execve");

I would just do perror("execve"), etc, because this is a child process
and according to the style guide you shouldn't use tst_resm in child
processes (I recommended that in the style guide for a very good
reason that you should understand).

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (waitpid=
(pid, &st, 0) =3D=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 tst_brkm(TBROK|TERRNO, NULL, "waitpid");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (! WIFEX=
ITED(st))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 tst_brkm(TBROK, NULL, "child exit status is %d", WEXITSTATUS(st));

I agree with what Cyril said before about whitespace.

...

-Garrett

---------------------------------------------------------------------------=
---
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
