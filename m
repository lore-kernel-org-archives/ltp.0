From: Li Wang <liwang@redhat.com>
Date: Fri, 31 Mar 2017 14:01:15 +0800
Subject: [LTP] [RFC PATCH 00/13] Convert LTP kernel/mem/testcase to New
	API
In-Reply-To: <20170330154358.GC886@rei.lan>
References: <20170328032239.11917-1-liwang@redhat.com>
 <20170330154358.GC886@rei.lan>
Message-ID: <CAEemH2cFcBz9QhZ8g+mZ2-z5RbCShU4eBcqnmwv1y+_=RWASrw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Mar 30, 2017 at 11:43 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> Seems the failed reason in oom02/5 is not testcase issue, it just because New API sets
>> test time in 5mins.
>
> The test_test structure has .timeout variable that, if set, overrides
> the default timeout. All you need to do is to to measure how long the
> test takes, then multiply it by something as 2 to be on a safe side
> and set the .timeout correspondingly.

Yes, but the problem we face is oom01 spend time is not the same on
different memory size machines. So, I'm afraid it is meaningless to
measure how long it takes on a fixed system.

Or, how about we just set a big vague number (i.e ".timeout = 3600")?


-- 
Regards,
Li Wang
Email: liwang@redhat.com
