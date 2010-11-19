Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PJLZs-0001I1-53
	for ltp-list@lists.sourceforge.net; Fri, 19 Nov 2010 07:40:12 +0000
Received: from out11.sjc.mx.trendmicro.com ([216.99.131.48])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PJLZq-0005aR-KZ
	for ltp-list@lists.sourceforge.net; Fri, 19 Nov 2010 07:40:12 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <000001cb8470$6662ddb0$33289910$@co.jp>	<AANLkTimGi4v_OHzZAD8BbyGKsuVzpBcokEECezPeTC8e@mail.gmail.com>	<000b01cb8481$c3c9a1d0$4b5ce570$@co.jp>	<AANLkTim3wqv3fS8Sg9TNvZ=nDuXGcTB4GmPcH4d9pEee@mail.gmail.com>	<001501cb848e$7e894960$7b9bdc20$@co.jp>	<AANLkTi=2ZMmCCHYFjX3ZK203hTHE9W=QTUZgDzkLyB=e@mail.gmail.com>	<000301cb8568$4a9060a0$dfb121e0$@co.jp>	<AANLkTi=Aia-KRKPT8JJtE_ts4jCPsDqjSF5cyhHMVjJo@mail.gmail.com>	<000601cb8603$7519a570$5f4cf050$@co.jp>	<AANLkTi=yU5JkGE496Gg5mOtaO2FRfdfF7wkNvUKEqnHu@mail.gmail.com>	<001601cb86b6$9d505ad0$d7f11070$@co.jp>
	<AANLkTi=V85s0-9tzTvdXtqedgQFABJWvW3pjQQ+F7DcM@mail.gmail.com>
In-Reply-To: <AANLkTi=V85s0-9tzTvdXtqedgQFABJWvW3pjQQ+F7DcM@mail.gmail.com>
Date: Fri, 19 Nov 2010 16:40:02 +0900
Message-ID: <000001cb87bc$f9bac740$ed3055c0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: Re: [LTP] Realtime test failure
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: 'Garrett Cooper' <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: Thursday, November 18, 2010 9:30 AM
> To: Mitani
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] Realtime test failure
> 
> > Thank you for your response.
> >
> > I tried to build with "ltp-66d67b5.tar.gz", but it failed in
> configure.
> > Therefore, I tried with older git "ltp-92dfd5b.tar.gz", and it
> succeeded
> > in RHEL5.5-x86 and RHEL4.8-x86 systems.
> >
> > From "ltp-92dfd5b.tar.gz" to "ltp-66d67b5.tar.gz", new probrem
> occured.
> >
> > New revisions are released in sequence. Therefore I intend to build
> > with the latest version again.
> 
> Huh...? What do you mean failed in configure? Logs please (PS the
> latest snapshot is different from that)!
> Thanks,
> -Garrett


"configure" failed with git "ltp-86209d2.tar.gz":
------------
./configure: line 8228: syntax error near unexpected token `elif'
./configure: line 8228: `elif test "x$has_quotav2" = "xyes"; then'
------------
(Detail log information is in my yesterday's email)

Environmants are RHEL5.5/4.8 -- x86/x86_64/ia64.


"${LTPROOT}/configure" file of "ltp-86209d2.tar.gz" is following:
------------< RHEL4.8 - x86>
[...]
  8204  done
  8205
  8206  cat >conftest.$ac_ext <<_ACEOF
  8207  /* confdefs.h.  */
  8208  _ACEOF
  8209  cat confdefs.h >>conftest.$ac_ext
  8210  cat >>conftest.$ac_ext <<_ACEOF
  8211  /* end confdefs.h.  */
  8212
  8213  #define _LINUX_QUOTA_VERSION 2
  8214  #include <sys/types.h>
  8215  #include <sys/quota.h>
  8216  #include <unistd.h>
  8217  int main(void) {
  8218          struct dqblk dq;
  8219          return quotactl(QCMD(Q_GETINFO, USRQUOTA), (const char *)
"/dev/null",
  8220                          geteuid(), (caddr_t) &dq);
  8221  }
  8222  if test "x$has_quotav1" = "xyes"; then
  8223
  8224  cat >>confdefs.h <<\_ACEOF
  8225  #define HAVE_QUOTAV1 1
  8226  _ACEOF
  8227
  8228  elif test "x$has_quotav2" = "xyes"; then
  8229
  8230  cat >>confdefs.h <<\_ACEOF
  8231  #define HAVE_QUOTAV2 1
  8232  _ACEOF
  8233
  8234  fi
  8235
  8236  _ACEOF
  8237  rm -f conftest.$ac_objext conftest$ac_exeext
  8238  if { (ac_try="$ac_link"
[...]
------------

The line 8210 ("  8210  cat >>conftest.$ac_ext <<_ACEOF") is the "here
document".
First "_ACEOF" which appears after this line is the line 8224.
But the line 8224 is "here document", too.

I think that it is syntax error.

In the line 8236, there is "_ACEOF".
This "_ACEOF" may be just after line 8221, I think.

I tried to execute "configure" after above revision, and it succeeded.
After this, "make" and "make install" succeeded, too.


Regards--

-Tomonori Mitani



------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
