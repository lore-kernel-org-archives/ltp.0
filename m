From: Saravana Kannan <saravanak@google.com>
Date: Wed, 13 Mar 2019 11:54:47 -0700
Subject: [LTP] [PATCH] setpriority01: Skip only PRIO_USER when unable to
 add test user
In-Reply-To: <CAGETcx-MnmCmjGDubaLfauQ0Rf6dayS8ykB7MbdL+U1_ajpTuw@mail.gmail.com>
References: <20190306215859.66044-1-saravanak@google.com>
 <20190307105933.GA1040@rei.lan>
 <CAGETcx-07fGeAxXzD6Lo79XG-0OXJS8wzHztw4_72m2rO9Hpcw@mail.gmail.com>
 <CAGETcx-yRfA+zmRScronhaVe6auMkzso6cHeDFtOaXzkE99Hwg@mail.gmail.com>
 <20190311160441.GB14497@rei.lan>
 <CAGETcx-MnmCmjGDubaLfauQ0Rf6dayS8ykB7MbdL+U1_ajpTuw@mail.gmail.com>
Message-ID: <CAGETcx9h4AooQxU4v7apAp4x+q_6xYYSaSFpEfSeBXHymqfN6Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Did you have any thoughts on the v2 patch? Want me to make any updates to
it?

Thanks,
Saravana

On Mon, Mar 11, 2019 at 11:23 AM Saravana Kannan <saravanak@google.com>
wrote:

>
>
> On Mon, Mar 11, 2019 at 9:05 AM Cyril Hrubis <chrubis@suse.cz> wrote:
>
>> Hi!
>> > > But is the test that's broken if useradd fails for wherever reason?
>> Isn't
>> > > it a configuration issue?
>> > >
>> > >
>> > Looking more into the definition of TBROK, TCONF and the code before my
>> > changes:
>> >
>> > -       if (eaccess("/etc/passwd", W_OK))
>> > -               tst_brk(TCONF, "/etc/passwd is not accessible");
>> > -
>> > -       tst_run_cmd(cmd_useradd, NULL, NULL, 0);
>> > -       user_added = 1;
>> > -
>> >
>> > Should an eaccess write failure have resulted in a TCONF? Shouldn't that
>> > have been a TBROK too?
>>
>> Looking at the git log this seems to be handling very specific case
>> where the rootfs is read only, quite likely this test was failing on
>> some specific embedded hardware. As far as I can tell this sounds like a
>> reasonable solution to the problem.
>>
>> > I'm fine with whatever way we go, except not wanting to fail the entire
>> > test case just because useradd isn't present in android. It's still very
>> > useful to run the other setpriority tests.
>>
>> Sounds good, there is no point not to map missing useradd to TCONF, I
>> just want to avoid mapping segfaulting or otherwise faulty useradd to
>> TCONF as well.
>>
>
> Thanks for the reviews and comments! I sent out a v2 patch that addressed
> your concerns. Can you please take a look at that and accept or suggest
> changes to it? In that patch, I treated the "no write permissions to
> /etc/passwd" as a TBROK and not TCONF as that seemed more appropriate to
> me. But if you want I can map that back to TCONF -- according to man pages,
> useradd has an error code for not being able to write to /etc/passwd.
>
> Thanks,
> Saravana
>
>
>>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190313/fa165e48/attachment.html>
