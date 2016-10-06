From: Dejan Jovicevic <Dejan.Jovicevic@rt-rk.com>
Date: Thu, 06 Oct 2016 14:59:27 +0200
Subject: [LTP]
 =?utf-8?b?Pz09P3V0Zi04P3E/ID89PT91dGYtOD9xPyBbUEFUQ0ggMS8y?=
 =?utf-8?q?=5D=3F=3D=3D=3Futf-8=3Fq=3F_llistxattr=3A_added_a_new_testcase_?=
 =?utf-8?q?to_llistxattr02?=
In-Reply-To: <20161006123804.GB10467@rei.lan>
Message-ID: <7c79-57f64a80-9-42da9f80@146381614>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it


=C2=A0Hi!
> +int longpath_setup(void)
> +{
> + int i;
> +
> + for (i =3D 0; i < PATH_MAX + 2; i++)
> + longpathname[i] =3D 'a';
> +
> + return 0;
> +}

Why don't we just do memset() in the setup()?

memset(longpathname, 'a', sizeof(longpathname) - 1);

Should do the same.

--
Cyril Hrubis
chrubis@suse.czYes, that's a very good point. I'll change it up in v2.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20161006/4ec1afa1/att=
achment.html>
