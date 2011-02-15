Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1PpM2M-0006T9-Eg
	for ltp-list@lists.sourceforge.net; Tue, 15 Feb 2011 14:37:54 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1PpM2L-0007EH-Lb
	for ltp-list@lists.sourceforge.net; Tue, 15 Feb 2011 14:37:54 +0000
Received: by wyb40 with SMTP id 40so213801wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 15 Feb 2011 06:37:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20110215031334.GA2884@hpt.nay.redhat.com>
References: <20110214061409.GA7983@hpt.nay.redhat.com>
	<AANLkTimzLhCfwAgHuB4S3Fo=gHkHEKbjs6ObficnqKXU@mail.gmail.com>
	<20110215031334.GA2884@hpt.nay.redhat.com>
Date: Tue, 15 Feb 2011 06:37:47 -0800
Message-ID: <AANLkTi=b7R39g8kn6_oNO6dgLp_Frss+v-iTAN6o=z13@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] ksm: wait 3 increments of full_scans before
 checking the results
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
To: Garrett Cooper <yanegomi@gmail.com>, ltp-list@lists.sourceforge.net, caiqian@redhat.com

On Mon, Feb 14, 2011 at 7:13 PM, Han Pingtian <phan@redhat.com> wrote:
> On Sun, Feb 13, 2011 at 10:25:54PM -0800, Garrett Cooper wrote:
>> On Sun, Feb 13, 2011 at 10:14 PM, Han Pingtian <phan@redhat.com> wrote:
>> > The KSM developer tell us that we should wait 3~5 increments of the
>> > /sys/kernel/mm/ksm/full_scans before checking ksm* testcases's results.
>> > Otherwise, there may be some stuck pages that cause the testing failed.
>>
>> =A0 =A0 A common mistake is thinking that sleep(3) is non-interruptable.
>> This proposed patch also has style-violations and is missing error
>> checking around lseek, et all. Please fix these items according to the
>> style guide.
>> Thanks,
>> -Garrett
> Thanks reviewing. The patched function will be called by
> testcases/kernel/mem/ksm/ksm* , which all call tst_sig() in setup().
> =A0So I think we have processed the interruptable problem of sleep().

    Are you sure? I suggest reading the RETURN VALUES section of
sleep(3), along with the notes about SA_RESTART in signal(7), and
compare that with what's implemented in the signal(3) equivalent in
tst_sig.
HTH,
-Garrett

---------------------------------------------------------------------------=
---
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
