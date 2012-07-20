Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ldoktor@redhat.com>) id 1SsCur-000839-6g
	for ltp-list@lists.sourceforge.net; Fri, 20 Jul 2012 13:06:45 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SsCul-0006BS-P2
	for ltp-list@lists.sourceforge.net; Fri, 20 Jul 2012 13:06:45 +0000
Message-ID: <500957D7.8000600@redhat.com>
Date: Fri, 20 Jul 2012 15:06:31 +0200
From: =?windows-1252?Q?Luk=E1=9A_Doktor?= <ldoktor@redhat.com>
MIME-Version: 1.0
References: <500952EC.6050504@redhat.com>
In-Reply-To: <500952EC.6050504@redhat.com>
Subject: Re: [LTP] Broken kernel/mem/ksm01 test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net, Cleber Rosa <crosa@redhat.com>, vlee@twitter.com

On 07/20/2012 02:45 PM, Luk=E1=9A Doktor wrote:
> Hi guys,
>
> I'm testing LTP-20120614 on Fedora 17 and it always stuck on ksm01 test.
>
> I went through sources and the problem is I have KSM already enabled =

> so the full_scans is a huge number. The function _group_check waits =

> till KSM does 3 * full_scans which in my case never ends (well it =

> might finish in a couple of years).
>
> To me it doesn't even make sense to wait 3 * full_scans as in the =

> first check it waits 1-2 seconds, in second check it waits few seconds =

> and it keeps growing further you goes.
>
> Would you please take look on this issue? I'd really appreciate it.
>
> Kind regards,
> Luk=E1=9A Doktor

Anyway if you think it should stay 3 * full_scans would you please at =

least reset the counter before the test start?

--- _mem.c      2012-07-20 13:39:20.351738873 +0200
+++ mem.c       2012-07-20 14:58:52.192157167 +0200
@@ -415,6 +415,7 @@ void create_same_memory(int size, int nu
                 }
         }
         tst_resm(TINFO, "KSM merging...");
+       write_file(PATH_KSM "run", "2");
         write_file(PATH_KSM "run", "1");
         snprintf(buf, BUFSIZ, "%ld", size * pages * num);
         write_file(PATH_KSM "pages_to_scan", buf);

I tested it and it works better (it fails, but at least it finishes). =

Anyway IMO it would be better to calculate the number of necessarily =

scans differently.

regards,
Luk=E1=9A

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
