Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <caiqian@cclom.cn>) id 1M7Se8-0008P4-Sz
	for ltp-list@lists.sourceforge.net; Fri, 22 May 2009 11:10:40 +0000
Received: from smtp109.biz.mail.mud.yahoo.com ([68.142.201.178])
	by 3b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1M7Se5-0005gW-B1
	for ltp-list@lists.sourceforge.net; Fri, 22 May 2009 11:10:40 +0000
Date: Fri, 22 May 2009 19:11:13 +0800 (CST)
Message-Id: <20090522.191113.98876286.caiqian@cclom.cn>
From: CAI Qian <caiqian@cclom.cn>
In-Reply-To: <d51f89b0905220403m29abd736scf6251b0ae3e4397@mail.gmail.com>
References: <23553926.post@talk.nabble.com>
	<20090521.153754.179938255.caiqian@cclom.cn>
	<d51f89b0905220403m29abd736scf6251b0ae3e4397@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [LTP] HTML report generation issue.
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
To: rohit.170309@gmail.com
Cc: ltp-list@lists.sourceforge.net

From: rohit verma <rohit.170309@gmail.com>
Subject: Re: [LTP] HTML report generation issue.
Date: Fri, 22 May 2009 16:33:56 +0530

> Hi,
> 
> In response to your query - "if there is any side-effect for single pan
> instance by using -O
> as default."
> 
> As per my understanding the pan driver creates files in the directory
> specified with the -O option for every testcase that is being executed. If
> the disk space is a constraint then using buffered mode might be an
> overhead. But, the space is only required when the LTP is running. After the
> execution of the tests all the files that are created during the buffering
> mode is deleted from the folder.
> 
> I feel, using the default buffered mode will not create an
> overhead/side-effect.
>

OK. Thanks.

CAI Qian
 
> Regards,
> rohit
> 
> 
> 
> 
> On Thu, May 21, 2009 at 1:07 PM, CAI Qian <caiqian@cclom.cn> wrote:
> 
>> From: rohitv <rohit.170309@gmail.com>
>> Subject: Re: [LTP] HTML report generation issue.
>> Date: Thu, 14 May 2009 23:04:13 -0700 (PDT)
>>
>> >
>> > Hi,
>> >
>> > Regarding the output coming out of place, can we use the output buffered
>> > mode as the default? Output buffered mode can be set with the -O option.
>> > But, this works only when no. of instances of LTP is more than 1
>> (specified
>> > by -x option). Currently, for few of the testcases the output generated
>> does
>> > not appear between <<<test_output>>> and <<<execution_status>>>, it can
>> be
>> > seen anywhere before <<<test_output>>> when corresponding .output file is
>> > checked. This might be because of race condition in the pan driver.  I
>> think
>> > by using the buffered output mode this problem can be fixed.
>> >
>>
>> Are you saying that when we use pan without -x option, it will not use
>> buffered mode even if specifying -O option? What I am interested to know
>> is that if there is any side-effect for single pan instance by using -O
>> as default.
>>
>> CAI Qian
>>
>> > Regards.
>> > --
>> > View this message in context:
>> http://www.nabble.com/HTML-report-generation-issue.-tp22925527p23553926.html
>> > Sent from the ltp-list mailing list archive at Nabble.com.
>> >
>> >
>> >
>> ------------------------------------------------------------------------------
>> > Crystal Reports - New Free Runtime and 30 Day Trial
>> > Check out the new simplified licensing option that enables
>> > unlimited royalty-free distribution of the report engine
>> > for externally facing server and web deployment.
>> > http://p.sf.net/sfu/businessobjects
>> > _______________________________________________
>> > Ltp-list mailing list
>> > Ltp-list@lists.sourceforge.net
>> > https://lists.sourceforge.net/lists/listinfo/ltp-list
>>

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
