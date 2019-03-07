From: Saravana Kannan <saravanak@google.com>
Date: Thu, 7 Mar 2019 14:36:38 -0800
Subject: [LTP] [PATCH] setpriority01: Skip only PRIO_USER when unable to
 add test user
In-Reply-To: <CAGETcx-07fGeAxXzD6Lo79XG-0OXJS8wzHztw4_72m2rO9Hpcw@mail.gmail.com>
References: <20190306215859.66044-1-saravanak@google.com>
 <20190307105933.GA1040@rei.lan>
 <CAGETcx-07fGeAxXzD6Lo79XG-0OXJS8wzHztw4_72m2rO9Hpcw@mail.gmail.com>
Message-ID: <CAGETcx-yRfA+zmRScronhaVe6auMkzso6cHeDFtOaXzkE99Hwg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Mar 7, 2019 at 7:44 AM Saravana Kannan <saravanak@google.com> wrote:

>
>
> On Thu, Mar 7, 2019, 3:00 AM Cyril Hrubis <chrubis@suse.cz> wrote:
>
>> Hi!
>> > -     ltpuser = SAFE_GETPWNAM(username);
>> > -     uid = ltpuser->pw_uid;
>> > +     if (!tst_run_cmd(cmd_useradd, NULL, NULL, 1)) {
>> > +             user_added = 1;
>> > +             ltpuser = SAFE_GETPWNAM(username);
>> > +             uid = ltpuser->pw_uid;
>> > +     }
>>
>> The only thing that I don't like here is that we do not check the cause
>> of failure here. What exactly happens on android, is useradd missing
>> there completely?
>
>
> Correct, useradd is missing.
>
> If so we should proceed with TCONF only if
>> tst_run_cmd() returned 255 and TBROK the test on other non-zero return
>> values.
>>
>
> But is the test that's broken if useradd fails for wherever reason? Isn't
> it a configuration issue?
>
>
Looking more into the definition of TBROK, TCONF and the code before my
changes:

-       if (eaccess("/etc/passwd", W_OK))
-               tst_brk(TCONF, "/etc/passwd is not accessible");
-
-       tst_run_cmd(cmd_useradd, NULL, NULL, 0);
-       user_added = 1;
-

Should an eaccess write failure have resulted in a TCONF? Shouldn't that
have been a TBROK too?

I'm fine with whatever way we go, except not wanting to fail the entire
test case just because useradd isn't present in android. It's still very
useful to run the other setpriority tests.

Thanks,
Saravana
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190307/9349e098/attachment-0001.html>
