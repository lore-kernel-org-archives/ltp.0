Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PfSew-0000yg-Es
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 07:40:50 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PfSeu-0001rN-79
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 07:40:50 +0000
Received: by wyb40 with SMTP id 40so524471wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 18 Jan 2011 23:40:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <OF556F8504.F2C4ACB7-ON8725781B.006F4CCC-0725781B.006FD309@us.ibm.com>
References: <OF556F8504.F2C4ACB7-ON8725781B.006F4CCC-0725781B.006FD309@us.ibm.com>
Date: Tue, 18 Jan 2011 23:40:41 -0800
Message-ID: <AANLkTi=wmuGxTXx+14UmxvFgocSK3YJXrfhcShmJbCY4@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] New ltp test case
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
To: Allison C Henderson <achender@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Mon, Jan 17, 2011 at 12:21 PM, Allison C Henderson
<achender@us.ibm.com> wrote:
>
> Hi All,
>
> I am new to the ltc filesystem team at IBM and we have been working on a =
new
> ltp test case for ext4. =A0The test case exercises the new punch hole fla=
g in
> the fallocate system call that we will be using to implement punch hole
> support for ext4. =A0Currently, there is no punch hole support for ext4, =
so
> the test just returns failed, but we wanted to add the test case to help
> verify that the new VFS changes to fallocate are working. =A0 I have incl=
uded
> a patch that adds the new ltp test case. =A0Let me know what you think.

Hi Allison,
    Welcome! Would you please look at the style guide I recently wrote
please for how to contribute testcases to LTP?
Thanks!
-Garrett

1. http://ltp.git.sourceforge.net/git/gitweb.cgi?p=3Dltp/ltp.git;a=3Dblob;f=
=3Ddoc/style-guide.txt;h=3Db6e3f6d70a85de64a621fa612046d7ad7bc12301;hb=3D45=
2fed5

---------------------------------------------------------------------------=
---
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand =

malware threats, the impact they can have on your business, and how you =

can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
