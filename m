Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OlP4z-0001Ff-Jx
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 16:32:01 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OlP4y-0008Ep-Mj
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 16:32:01 +0000
Received: by bwz12 with SMTP id 12so3864644bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 17 Aug 2010 09:31:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C6AB19B.6060706@redhat.com>
References: <4C6AB19B.6060706@redhat.com>
Date: Tue, 17 Aug 2010 09:31:54 -0700
Message-ID: <AANLkTimurpbzZtn50_UNh0SRWsBPNWDcCYpbinNPH4Gj@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=001636c5a368ad8175048e077c0e
Subject: Re: [LTP] running LTP on uClinux
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: dmarlin@redhat.com
Cc: ltp-list <ltp-list@lists.sourceforge.net>

--001636c5a368ad8175048e077c0e
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 17, 2010 at 8:58 AM, David Marlin <dmarlin@redhat.com> wrote:
>
> I was building LTP to test a uClinux system, but encountered some
> problems. =A0As far as I could tell UCLINUX=3D1 is not being passed to al=
l
> testcases when defined at the top level before running make.
>
> =A0 export UCLINUX=3D1
> =A0 make
>
>
> I modified the following file and the build proceeded as expected:
>
> --- include/mk/testcases.mk.orig =A0 =A0 2010-04-01 01:23:08.000000000 -0=
500
> +++ include/mk/testcases.mk =A0 =A0 2010-07-01 17:38:10.240628708 -0500
> @@ -53,3 +53,8 @@
>
> =A0$(APICMDS_DIR) $(LIBLTP_DIR) $(abs_top_builddir)/$(TKI_DIR): %:
> =A0 =A0 =A0 =A0 mkdir -p "$@"
> +
> +ifeq ($(UCLINUX),1)
> +CFLAGS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D -D__UCLIBC__ -DUCLINUX
> +endif
>
>
> Has anyone else had to make similar changes in order to build LTP for
> uClinux?

It should be CPPFLAGS, and the definition should be in env_post.mk; I
never had a UCLINUX infrastructure to test with, so this might have
fallen between the cracks by accident about 8 months ago.

Let me know how this patch works for you.

Thanks,
-Garrett

--001636c5a368ad8175048e077c0e
Content-Type: application/octet-stream; name="fix-ltp-uclinux-compiles.diff"
Content-Disposition: attachment; filename="fix-ltp-uclinux-compiles.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gcyyzj6u0

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbWsvZW52X3Bvc3QubWsgYi9pbmNsdWRlL21rL2Vudl9wb3N0
Lm1rCmluZGV4IDU2YWNhMjcuLmViYWVlMWYgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbWsvZW52X3Bv
c3QubWsKKysrIGIvaW5jbHVkZS9tay9lbnZfcG9zdC5tawpAQCAtMzcsNiArMzcsMTAgQEAgQ1BQ
RkxBR1MJCQkrPSAtSSQodG9wX3NyY2RpcikvaW5jbHVkZSAtSSQodG9wX2J1aWxkZGlyKS9pbmNs
dWRlCiAKIExERkxBR1MJCQkJKz0gLUwkKHRvcF9idWlsZGRpcikvbGliCiAKK2lmZXEgKCQoVUNM
SU5VWCksMSkKK0NQUEZMQUdTCQkJKz0gLURfX1VDTElCQ19fIC1EVUNMSU5VWAorZW5kaWYKKwog
TUFLRV9UQVJHRVRTCQkJPz0gJChub3RkaXIgJChwYXRzdWJzdCAlLmMsJSwkKHdpbGRjYXJkICQo
YWJzX3NyY2RpcikvKi5jKSkpCiAKIE1BS0VfVEFSR0VUUwkJCTo9ICQoZmlsdGVyLW91dCAkKEZJ
TFRFUl9PVVRfTUFLRV9UQVJHRVRTKSwkKE1BS0VfVEFSR0VUUykpCg==
--001636c5a368ad8175048e077c0e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
--001636c5a368ad8175048e077c0e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--001636c5a368ad8175048e077c0e--

