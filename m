From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 18 Feb 2016 12:14:41 +0300
Subject: [LTP] Test library API changes
In-Reply-To: <20160217155406.GA12574@rei>
References: <20160105111136.GA32659@rei.lan> <20160209174618.GB5441@rei.lan>
 <1670220208.19308377.1455100978449.JavaMail.zimbra@redhat.com>
 <20160210114134.GA10106@rei.lan> <20160211160313.GA22877@rei.lan>
 <116630920.20260383.1455280426104.JavaMail.zimbra@redhat.com>
 <20160212175308.GA30723@rei.suse.cz> <20160216211958.GC2515@rei.lan>
 <1799339064.21851637.1455719961718.JavaMail.zimbra@redhat.com>
 <20160217155406.GA12574@rei>
Message-ID: <56C58B81.3080006@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 02/17/2016 06:54 PM, Cyril Hrubis wrote:
> Hi!
>> Here are some comments/questions/ideas:
>>
>> 1. acnt appears to be unused now
> I haven't removed it yet... I'm still thinking how we can generate
> things like TAP output that expects us to print exact number of tests on
> the first line followed by exact number of result lines and make as
> little rules for result reporting as possible.
>
> Maybe we can just say that testcases that define test_all do one just
> one test and produce one result per such test and do more detailed
> reporting only for testcases that define tcnt.
>
> Or we can turn on the detailed reporting only if acnt has been set.

Not sure, but if I read TAP spec correctly, it doesn't strictly define
that it should beon the first line, rather appear only once at the start
or at the end (if the number of test points is not known).

So if tcnt for the test plan, what is 'acnt' for? ... I didn't find the
analogy in the TAP spec.

Looking at the 'struct tst_test',

* the names like 'tcnt' and 'acnt' seem not clear. May be we should name 
'tcnt' as
test_planor test_count?

* also, why bitfields in the struct tst_test have different number of 
storage bits?

   int needs_tmpdir:1;
   int needs_root:2;
   int forks_child:3;
   int needs_device:4;
   int needs_checkpoints:5;

if their value is just '0' or '1', ':1' - should be instead.

Best regards,
Alexey
