Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yardleyb@us.ibm.com>) id 1NT3fP-0002dI-1P
	for ltp-list@lists.sourceforge.net; Fri, 08 Jan 2010 01:29:31 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NT3fM-0005Q6-J2
	for ltp-list@lists.sourceforge.net; Fri, 08 Jan 2010 01:29:30 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o081O7xN024432
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 18:24:07 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o081TD0D098448
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 18:29:13 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o081TC4d005478
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 18:29:13 -0700
In-Reply-To: <1262862380.12213.23.camel@subratamodak.linux.ibm.com>
References: <2FB9CEFCF4B24FC7AE1D718C54B63F55@jacksimba>
	<1262862380.12213.23.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
From: Brent Yardley <yardleyb@us.ibm.com>
Message-ID: <OF06E672E4.7EA44CCB-ON882576A4.00564158-882576A5.00082637@us.ibm.com>
Date: Thu, 7 Jan 2010 18:29:10 -0700
Content-Type: multipart/mixed; boundary="=_mixed 000764C6882576A5_="
Subject: Re: [LTP] disktest question
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

--=_mixed 000764C6882576A5_=
Content-Type: multipart/alternative;
	boundary="=_alternative 000764C6882576A5_="


--=_alternative 000764C6882576A5_=
Content-Type: text/plain; charset="US-ASCII"

Here are a couple of thoughts.

Disktest will force a sync at the end of all write IO operations, when not 
raw / directio, this sync can take quite a bit of time depending on how 
full the buffer cache is.  This additional time to sync the IO to the disk 
is added to the overall IO time, it assumes that performance is to measure 
the time it takes to get the data to the disk, and this may be what is 
causing the difference between what you are seeing between dd and 
disktest.  Also, dd will perform a sequential copy, the default for 
disktest is to perform random seeks, so you will need to add a -pl to the 
command line to compare disktest with dd.

I have been working on an experimental patch to time IOs in disktest at 
the usec level and to only include the time when IO was actually in 
flight, ie. from the start to end of each write/read command this will 
also exclude an time it takes to sync to the disk.  This is more in-line I 
believe with how dd measures the throughput.  I have included the patch 
here if you would like to try it out, and see if the numbers more closely 
match what you are seeing in dd.



If you want to specifically understand the performance of the device your 
testing, I would recommend using the -Ibd option.  This will force the 
bypass of kernel buffer caching and will be testing the performance of the 
device and transport only.

Another test that is useful and tests the specific performance of the 
transport for devices that have caching enabled, is to use the -S0:0 
option with the -Ibd options.  This forces disktest to always request the 
block data from the same block.  When used with a high -B and -K, this 
should give you your max throughput, and used with a small -B and high -K, 
this will give you your make IOPS.

Let me know how things go or if you have further questions.

Thanks,
Brent




From:
Subrata Modak <subrata@linux.vnet.ibm.com>
To:
Yongjian Zhang <brianzhang2007@gmail.com>
Cc:
ltp-list@lists.sourceforge.net, Brent Yardley/Beaverton/IBM@IBMUS
Date:
01/07/2010 03:06 AM
Subject:
Re: [LTP] disktest question



On Tue, 2010-01-05 at 10:23 -0700, Yongjian Zhang wrote: 
> Hi all,
> 
> I'm trying to use disktest to measure the performance of an iSCSI device 
but 
> get extremely low throughput...
> 

How about the following manpage inside LTP source:

# man ./testcases/kernel/io/disktest/man1/disktest.1

Regards--
Subrata

> For example, I did
> 
> disktest -w -S0:1k -B 1024 /dev/sdb (/dev/sdb is the iSCSI device file, 
no 
> partition or file system on it)
> 
> And the result was:
> | 2010/01/05-02:58:26 | START | 27293 | v1.4.2 | /dev/sdb | Start
> args: -w -S0:1024k -B 1024 -PA (-I b) (-N 8385867) (-K 4) (-c) (-p R)
> (-L 1048577) (-D 0:100) (-t 0:2m) (-o 0)
> | 2010/01/05-02:58:26 | INFO  | 27293 | v1.4.2 | /dev/sdb | Starting
> pass
> ^C| 2010/01/05-03:00:58 | STAT  | 27293 | v1.4.2 | /dev/sdb | Total
> bytes written in 85578 transfers: 87631872
> | 2010/01/05-03:00:58 | STAT  | 27293 | v1.4.2 | /dev/sdb | Total
> write throughput: 701055.0B/s (0.67MB/s), IOPS 684.6/s.
> | 2010/01/05-03:00:58 | STAT  | 27293 | v1.4.2 | /dev/sdb | Total
> Write Time: 125 seconds (0d0h2m5s)
> | 2010/01/05-03:00:58 | STAT  | 27293 | v1.4.2 | /dev/sdb | Total
> overall runtime: 152 seconds (0d0h2m32s)
> | 2010/01/05-03:00:58 | END   | 27293 | v1.4.2 | /dev/sdb | User
> Interrupt: Test Done (Passed)
> 
> As you can see, the throughput was only 0.67MB/s and only 85578
> written in 87631872 transfers...
> I also tweaked the options with "-p l" and/or "-I bd" (change seek
> pattern to linear and/or speficy IO type as block and direct IO) but
> no improvement happened...
> 
> I thought this low throughput could be caused by the link rate or disk 
> problem, but dd ruled it out..
> 
> $ dd if=/dev/zero of=/dev/sdb bs=1024 count=1048576
> 
> The throughput is 7.2 MB/s.
> 
> There must be something I've done wrong with disktest... Could anyone 
maybe 
> help me out here?
> 
> Thanks a lot!
> 
> jack 
> 
> 
> 
------------------------------------------------------------------------------
> This SF.Net email is sponsored by the Verizon Developer Community
> Take advantage of Verizon's best-in-class app development support
> A streamlined, 14 day to market process makes app distribution fast and 
easy
> Join now and get one step closer to millions of Verizon customers
> http://p.sf.net/sfu/verizon-dev2dev 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list




--=_alternative 000764C6882576A5_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Here are a couple of thoughts.</font>
<br>
<br><font size=2 face="sans-serif">Disktest will force a sync at the end
of all write IO operations, when not raw / directio, this sync can take
quite a bit of time depending on how full the buffer cache is. &nbsp;This
additional time to sync the IO to the disk is added to the overall IO time,
it assumes that performance is to measure the time it takes to get the
data to the disk, and this may be what is causing the difference between
what you are seeing between dd and disktest. &nbsp;Also, dd will perform
a sequential copy, the default for disktest is to perform random seeks,
so you will need to add a -pl to the command line to compare disktest with
dd.</font>
<br>
<br><font size=2 face="sans-serif">I have been working on an experimental
patch to time IOs in disktest at the usec level and to only include the
time when IO was actually in flight, ie. from the start to end of each
write/read command this will also exclude an time it takes to sync to the
disk. &nbsp;This is more in-line I believe with how dd measures the throughput.
&nbsp;I have included the patch here if you would like to try it out, and
see if the numbers more closely match what you are seeing in dd.</font>
<br>
<br>
<br>
<br><font size=2 face="sans-serif">If you want to specifically understand
the performance of the device your testing, I would recommend using the
-Ibd option. &nbsp;This will force the bypass of kernel buffer caching
and will be testing the performance of the device and transport only.</font>
<br>
<br><font size=2 face="sans-serif">Another test that is useful and tests
the specific performance of the transport for devices that have caching
enabled, is to use the -S0:0 option with the -Ibd options. &nbsp;This forces
disktest to always request the block data from the same block. &nbsp;When
used with a high -B and -K, this should give you your max throughput, and
used with a small -B and high -K, this will give you your make IOPS.</font>
<br>
<br><font size=2 face="sans-serif">Let me know how things go or if you
have further questions.</font>
<br><font size=2 face="sans-serif"><br>
</font><font size=3>Thanks,<br>
Brent</font>
<br>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td><font size=1 color=#5f5f5f face="sans-serif">From:</font>
<td><font size=1 face="sans-serif">Subrata Modak &lt;subrata@linux.vnet.ibm.com&gt;</font>
<tr valign=top>
<td><font size=1 color=#5f5f5f face="sans-serif">To:</font>
<td><font size=1 face="sans-serif">Yongjian Zhang &lt;brianzhang2007@gmail.com&gt;</font>
<tr>
<td valign=top><font size=1 color=#5f5f5f face="sans-serif">Cc:</font>
<td><font size=1 face="sans-serif">ltp-list@lists.sourceforge.net, Brent
Yardley/Beaverton/IBM@IBMUS</font>
<tr valign=top>
<td><font size=1 color=#5f5f5f face="sans-serif">Date:</font>
<td><font size=1 face="sans-serif">01/07/2010 03:06 AM</font>
<tr valign=top>
<td><font size=1 color=#5f5f5f face="sans-serif">Subject:</font>
<td><font size=1 face="sans-serif">Re: [LTP] disktest question</font></table>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>On Tue, 2010-01-05 at 10:23 -0700, Yongjian Zhang
wrote: <br>
&gt; Hi all,<br>
&gt; <br>
&gt; I'm trying to use disktest to measure the performance of an iSCSI
device but <br>
&gt; get extremely low throughput...<br>
&gt; <br>
<br>
How about the following manpage inside LTP source:<br>
<br>
# man ./testcases/kernel/io/disktest/man1/disktest.1<br>
<br>
Regards--<br>
Subrata<br>
<br>
&gt; For example, I did<br>
&gt; <br>
&gt; disktest -w -S0:1k -B 1024 /dev/sdb (/dev/sdb is the iSCSI device
file, no <br>
&gt; partition or file system on it)<br>
&gt; <br>
&gt; And the result was:<br>
&gt; | 2010/01/05-02:58:26 | START | 27293 | v1.4.2 | /dev/sdb | Start<br>
&gt; args: -w -S0:1024k -B 1024 -PA (-I b) (-N 8385867) (-K 4) (-c) (-p
R)<br>
&gt; (-L 1048577) (-D 0:100) (-t 0:2m) (-o 0)<br>
&gt; | 2010/01/05-02:58:26 | INFO &nbsp;| 27293 | v1.4.2 | /dev/sdb | Starting<br>
&gt; pass<br>
&gt; ^C| 2010/01/05-03:00:58 | STAT &nbsp;| 27293 | v1.4.2 | /dev/sdb |
Total<br>
&gt; bytes written in 85578 transfers: 87631872<br>
&gt; | 2010/01/05-03:00:58 | STAT &nbsp;| 27293 | v1.4.2 | /dev/sdb | Total<br>
&gt; write throughput: 701055.0B/s (0.67MB/s), IOPS 684.6/s.<br>
&gt; | 2010/01/05-03:00:58 | STAT &nbsp;| 27293 | v1.4.2 | /dev/sdb | Total<br>
&gt; Write Time: 125 seconds (0d0h2m5s)<br>
&gt; | 2010/01/05-03:00:58 | STAT &nbsp;| 27293 | v1.4.2 | /dev/sdb | Total<br>
&gt; overall runtime: 152 seconds (0d0h2m32s)<br>
&gt; | 2010/01/05-03:00:58 | END &nbsp; | 27293 | v1.4.2 | /dev/sdb | User<br>
&gt; Interrupt: Test Done (Passed)<br>
&gt; <br>
&gt; As you can see, the throughput was only 0.67MB/s and only 85578<br>
&gt; written in 87631872 transfers...<br>
&gt; I also tweaked the options with &quot;-p l&quot; and/or &quot;-I bd&quot;
(change seek<br>
&gt; pattern to linear and/or speficy IO type as block and direct IO) but<br>
&gt; no improvement happened...<br>
&gt; <br>
&gt; I thought this low throughput could be caused by the link rate or
disk <br>
&gt; problem, but dd ruled it out..<br>
&gt; <br>
&gt; $ dd if=/dev/zero of=/dev/sdb bs=1024 count=1048576<br>
&gt; <br>
&gt; The throughput is 7.2 MB/s.<br>
&gt; <br>
&gt; There must be something I've done wrong with disktest... Could anyone
maybe <br>
&gt; help me out here?<br>
&gt; <br>
&gt; Thanks a lot!<br>
&gt; <br>
&gt; jack <br>
&gt; <br>
&gt; <br>
&gt; ------------------------------------------------------------------------------<br>
&gt; This SF.Net email is sponsored by the Verizon Developer Community<br>
&gt; Take advantage of Verizon's best-in-class app development support<br>
&gt; A streamlined, 14 day to market process makes app distribution fast
and easy<br>
&gt; Join now and get one step closer to millions of Verizon customers<br>
&gt; </font></tt><a href="http://p.sf.net/sfu/verizon-dev2dev"><tt><font size=2>http://p.sf.net/sfu/verizon-dev2dev</font></tt></a><tt><font size=2>
<br>
&gt; _______________________________________________<br>
&gt; Ltp-list mailing list<br>
&gt; Ltp-list@lists.sourceforge.net<br>
&gt; </font></tt><a href="https://lists.sourceforge.net/lists/listinfo/ltp-list"><tt><font size=2>https://lists.sourceforge.net/lists/listinfo/ltp-list</font></tt></a><tt><font size=2><br>
<br>
</font></tt>
<br>
<br>
--=_alternative 000764C6882576A5_=--

--=_mixed 000764C6882576A5_=
Content-Type: application/octet-stream; name="patch.gz"
Content-Disposition: attachment; filename="patch.gz"
Content-Transfer-Encoding: base64

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
zkZORaQ0NKLWpdLuueK1gpy5wfscITm3T5GzzSAnlIMn6Nlm0BOdHN6OvoY/YVVtTPifzaPc+Rlk
vYBPcbCv4FU+gGfL3/jmapoWv/13hnc0xvdyjvDXLf3aj0ZSsTAryYb9d7X20p+PPwMAeZxM9kTX
El9K8l7+9NfT4aCHd9SWCSein37CaEUzXd7Nkz7B7TQlBEHtG42n1T7mzMXVPtb156p9zCVN69ku
iY5NTWvZK5Q+gyVRiDvlOINneXPzVV6MzuFMTC/iMpY/kxcP583MV/M8gNssUiKr2zU1i5Z8ffhO
qh1R7FfodR7Dn7eEpEpPR9P+kFTa12bu3dCLLPQHphBUQqnx78OgUjfbWUo9jWt1PCqKq3W87/vo
9TRPseNRXlqZhCecoUnxmWlVCmYm1Xqap9dZTIlB3D6Llgy1DmYmBSqDL3lsiSlE6EE+nzPZs7Mo
un2KogztDr3W5/Mne/b30G+hljuv9bKVO6XQEWaxcg7Jueq80JaKZ7i94O98tZqgol369lWUVP6n
k0F/mn+K/09zV9vbtg2EP+dfCAU62JOdxHbdOC06oAuyxkDbFImxfhlgGLEaa/NL5pe6+ZD/Pt7x
VeKdRMVe0gJtUpE88si7E4/iPYeab/TdfPVk5sX5UIWfJq8H7wf60+TF1eACllfHKx/YICtmA5kJ
vcpssB0aVYg4NNzHreNXve7J68N62Nj0W4Iem1ncEAYLd8gOnQAmWToMpyGDlJyWbMO9L+JsfHKB
bHwNl42tv6zu6z1INIppPF42tp5sTLIv34BZ3zKikdndBckGYSzzhB4vHFtGOChfyEiHY6CCfIj9
WZ+zEutD7mathgcZn2Iaj7U95G6ZHBkvX8TI+C03L1wVtvwVJYtgkie9J6NzVmJ0SK/CVAmyOcEk
Hi8SvskJsjjEyAocnzCRKHO9dpAJytpUtTVVnZtdzM2gxNzQ22xTR7sQvGQFEqgmV8T+nSLKSxU1
Kt59YIWqihNSTaYoDos8lH3YmUGJnaEdHDvr20qywBPYQRZ8I3NrPRAPL9n9EzBU3psrIx0yDTRp
TmoezQojSnnXkrROGV+t3e40Ou0obnfwp/LVVtt0fTOpmTwNRt5CfDg0pNXsmhIK/KSt7ui/U6G/
yJHr8hgEKiv5KPgvLhLh8sKWEdGuNO7URn0RXUU14TBPxN+Z+Luq4+VU95jb6fxwstjAnWD30Syd
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
f99/6YuNaDpFksuMa2pOVv4DqIPLUIaKAAA=

--=_mixed 000764C6882576A5_=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
--=_mixed 000764C6882576A5_=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--=_mixed 000764C6882576A5_=--

