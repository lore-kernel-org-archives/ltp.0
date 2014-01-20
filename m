Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sedat.dilek@gmail.com>) id 1W5BTn-00058H-Pu
	for ltp-list@lists.sourceforge.net; Mon, 20 Jan 2014 09:49:15 +0000
Received: from mail-wi0-f169.google.com ([209.85.212.169])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1W5BTn-0002Wg-3q
	for ltp-list@lists.sourceforge.net; Mon, 20 Jan 2014 09:49:15 +0000
Received: by mail-wi0-f169.google.com with SMTP id e4so4198592wiv.4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 20 Jan 2014 01:49:08 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 20 Jan 2014 10:49:08 +0100
Message-ID: <CA+icZUW10VjLz6V+yXwVHCaY6cMP2CJVowaGzsvt=+qrvG-G=g@mail.gmail.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: multipart/mixed; boundary=001a1134d2309bab6b04f063cd23
Subject: [LTP] runltp-lite: Creates no logs below results-dir
Reply-To: sedat.dilek@gmail.com
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
To: ltp-list <ltp-list@lists.sourceforge.net>

--001a1134d2309bab6b04f063cd23
Content-Type: text/plain; charset=UTF-8

Happy new 2014,

congrats to ltp-full-20140115!

Recently, I have tested it with Linux v3.13-rc8+ (IPC-syscalls and runltp-lite)

  $ ./runltp -f syscalls-ipc

  $ ./runltplite.sh

The 1st result-log is attached.
Is it possible that runltp-lite also saves its output to results-dir?

Thanks.

Regards,
- Sedat -

--001a1134d2309bab6b04f063cd23
Content-Type: text/x-log; charset=US-ASCII;
	name="LTP_RUN_ON-2014_Jan_17-10h_36m_39s.log"
Content-Disposition: attachment; 
	filename="LTP_RUN_ON-2014_Jan_17-10h_36m_39s.log"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hqnjvna20

VGVzdCBTdGFydCBUaW1lOiBGcmkgSmFuIDE3IDEwOjM2OjQwIDIwMTQKLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KVGVzdGNhc2UgICAgICAgICAgICAgICAgICAgICAg
IFJlc3VsdCAgICAgRXhpdCBWYWx1ZQotLS0tLS0tLSAgICAgICAgICAgICAgICAgICAgICAgLS0t
LS0tICAgICAtLS0tLS0tLS0tCm1zZ2N0bDAxICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAg
ICAgIDAgICAgCm1zZ2N0bDAyICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAg
Cm1zZ2N0bDAzICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCm1zZ2N0bDA0
ICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCm1zZ2N0bDA1ICAgICAgICAg
ICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCm1zZ2N0bDA2ICAgICAgICAgICAgICAgICAg
ICAgICBQQVNTICAgICAgIDAgICAgCm1zZ2N0bDA3ICAgICAgICAgICAgICAgICAgICAgICBQQVNT
ICAgICAgIDAgICAgCm1zZ2N0bDA4ICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAg
ICAgCm1zZ2N0bDA5ICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCm1zZ2N0
bDEwICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCm1zZ2N0bDExICAgICAg
ICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCm1zZ2dldDAxICAgICAgICAgICAgICAg
ICAgICAgICBQQVNTICAgICAgIDAgICAgCm1zZ2dldDAyICAgICAgICAgICAgICAgICAgICAgICBQ
QVNTICAgICAgIDAgICAgCm1zZ2dldDAzICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAg
IDAgICAgCm1zZ2dldDA0ICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCm1z
Z3JjdjAxICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCm1zZ3JjdjAyICAg
ICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCm1zZ3JjdjAzICAgICAgICAgICAg
ICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCm1zZ3JjdjA0ICAgICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgIDAgICAgCm1zZ3JjdjA1ICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAg
ICAgIDAgICAgCm1zZ3JjdjA2ICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAg
Cm1zZ3NuZDAxICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCm1zZ3NuZDAy
ICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCm1zZ3NuZDAzICAgICAgICAg
ICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCm1zZ3NuZDA0ICAgICAgICAgICAgICAgICAg
ICAgICBQQVNTICAgICAgIDAgICAgCm1zZ3NuZDA1ICAgICAgICAgICAgICAgICAgICAgICBQQVNT
ICAgICAgIDAgICAgCm1zZ3NuZDA2ICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAg
ICAgCnNlbWN0bDAxICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCnNlbWN0
bDAyICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCnNlbWN0bDAzICAgICAg
ICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCnNlbWN0bDA0ICAgICAgICAgICAgICAg
ICAgICAgICBQQVNTICAgICAgIDAgICAgCnNlbWN0bDA1ICAgICAgICAgICAgICAgICAgICAgICBQ
QVNTICAgICAgIDAgICAgCnNlbWN0bDA2ICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAg
IDAgICAgCnNlbWN0bDA3ICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCnNl
bWdldDAxICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCnNlbWdldDAyICAg
ICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCnNlbWdldDAzICAgICAgICAgICAg
ICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCnNlbWdldDA1ICAgICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgIDAgICAgCnNlbWdldDA2ICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAg
ICAgIDAgICAgCnNlbW9wMDEgICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAg
CnNlbW9wMDIgICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCnNlbW9wMDMg
ICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCnNlbW9wMDQgICAgICAgICAg
ICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCnNlbW9wMDUgICAgICAgICAgICAgICAgICAg
ICAgICBQQVNTICAgICAgIDAgICAgCnNobWF0MDEgICAgICAgICAgICAgICAgICAgICAgICBQQVNT
ICAgICAgIDAgICAgCnNobWF0MDIgICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAg
ICAgCnNobWF0MDMgICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCnNobWN0
bDAxICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCnNobWN0bDAyICAgICAg
ICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCnNobWN0bDAzICAgICAgICAgICAgICAg
ICAgICAgICBQQVNTICAgICAgIDAgICAgCnNobWN0bDA0ICAgICAgICAgICAgICAgICAgICAgICBQ
QVNTICAgICAgIDAgICAgCnNobWR0MDEgICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAg
IDAgICAgCnNobWR0MDIgICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCnNo
bWdldDAxICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCnNobWdldDAyICAg
ICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCnNobWdldDAzICAgICAgICAgICAg
ICAgICAgICAgICBQQVNTICAgICAgIDAgICAgCnNobWdldDA0ICAgICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgIDAgICAgCnNobWdldDA1ICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAg
ICAgIDAgICAgCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQpUb3RhbCBUZXN0czogNTgKVG90YWwgRmFpbHVyZXM6IDAKS2VybmVsIFZlcnNpb246IDMuMTMu
MC1yYzgtNDktaW5pemEtc21hbGwKTWFjaGluZSBBcmNoaXRlY3R1cmU6IHg4Nl82NApIb3N0bmFt
ZTogZmFtYm94Cgo=
--001a1134d2309bab6b04f063cd23
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
--001a1134d2309bab6b04f063cd23
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--001a1134d2309bab6b04f063cd23--

