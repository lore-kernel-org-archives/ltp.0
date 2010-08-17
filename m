Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dmarlin@redhat.com>) id 1OlQtE-0006Ds-Es
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 18:28:00 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OlQtB-0000p9-1L
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 18:28:00 +0000
Message-ID: <4C6AD4A3.50505@redhat.com>
Date: Tue, 17 Aug 2010 13:27:47 -0500
From: David Marlin <dmarlin@redhat.com>
MIME-Version: 1.0
References: <4C6AB19B.6060706@redhat.com>
	<AANLkTimurpbzZtn50_UNh0SRWsBPNWDcCYpbinNPH4Gj@mail.gmail.com>
In-Reply-To: <AANLkTimurpbzZtn50_UNh0SRWsBPNWDcCYpbinNPH4Gj@mail.gmail.com>
Subject: Re: [LTP] running LTP on uClinux
Reply-To: dmarlin@redhat.com
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>


Garrett Cooper wrote:
> On Tue, Aug 17, 2010 at 8:58 AM, David Marlin <dmarlin@redhat.com> wrote:
>> I was building LTP to test a uClinux system, but encountered some
>> problems.  As far as I could tell UCLINUX=1 is not being passed to all
>> testcases when defined at the top level before running make.
>>
>>   export UCLINUX=1
>>   make
>>
>>
>> I modified the following file and the build proceeded as expected:
>>
>> --- include/mk/testcases.mk.orig     2010-04-01 01:23:08.000000000 -0500
>> +++ include/mk/testcases.mk     2010-07-01 17:38:10.240628708 -0500
>> @@ -53,3 +53,8 @@
>>
>>  $(APICMDS_DIR) $(LIBLTP_DIR) $(abs_top_builddir)/$(TKI_DIR): %:
>>         mkdir -p "$@"
>> +
>> +ifeq ($(UCLINUX),1)
>> +CFLAGS                  += -D__UCLIBC__ -DUCLINUX
>> +endif
>>
>>
>> Has anyone else had to make similar changes in order to build LTP for
>> uClinux?
> 
> It should be CPPFLAGS, and the definition should be in env_post.mk; I
> never had a UCLINUX infrastructure to test with, so this might have
> fallen between the cracks by accident about 8 months ago.
> 
> Let me know how this patch works for you.

The patch works for me.  Thank you.

I am now seeing some other UCLINUX related problems/questions with 
individual testcases, but will follow up in separate emails on those.


Thanks again,

d.marlin
==========

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
