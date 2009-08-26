Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <paul.larson@canonical.com>) id 1MgL4B-0000yi-Df
	for ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 16:09:43 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MgL42-0005DP-6u
	for ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 16:09:38 +0000
Message-ID: <4A955E35.9010001@canonical.com>
Date: Wed, 26 Aug 2009 11:09:25 -0500
From: Paul Larson <paul.larson@canonical.com>
MIME-Version: 1.0
References: <4A8C4246.4060607@canonical.com>
	<alpine.LRH.2.00.0908261748140.17269@vixen.sonytel.be>
In-Reply-To: <alpine.LRH.2.00.0908261748140.17269@vixen.sonytel.be>
Subject: Re: [LTP] fix for file_test for systems without rpm installed
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
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

Geert Uytterhoeven wrote:
> On Wed, 19 Aug 2009, Paul Larson wrote:
>> Here's the fixed version, forgot I needed to redo these...
>>
>> If you run file_test.sh on a system without rpm installed, it should
>> return tconf instead of tfail.
>>
>> Signed-off-by: Paul Larson <paul.larson@canonical.com>
>> ---
> 
>> index 4fc9dec..4e30d43 100755
>> --- a/testcases/commands/ade/file/file_test.sh
>> +++ b/testcases/commands/ade/file/file_test.sh
>> @@ -582,11 +587,7 @@ fi
>>  export TCID=file10
>>  export TST_COUNT=10
>>  
>> -if [ -f /etc/redhat-release ]; then
>> -   KERNEL=vmlinuz
>> -else
>> -   KERNEL=vmlinux
>> -fi
>> +KERNEL=vmlinu
>>  
>>  $LTPBIN/tst_resm TINFO "TEST #10: file command recognizes $KERNEL file"
> 
> I guess this change was not supposed to be part of this patch?
> 
> Not that I'm complaining, as it fixes another vmlinuz vs. vmlinux mismatch I
> was seeing ;-)
Ha, yeah I just forgot to mention it too.  And that was exactly the
reason for it.

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
