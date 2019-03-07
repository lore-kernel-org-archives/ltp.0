From: Saravana Kannan <saravanak@google.com>
Date: Thu, 7 Mar 2019 07:44:55 -0800
Subject: [LTP] [PATCH] setpriority01: Skip only PRIO_USER when unable to
 add test user
In-Reply-To: <20190307105933.GA1040@rei.lan>
References: <20190306215859.66044-1-saravanak@google.com>
 <20190307105933.GA1040@rei.lan>
Message-ID: <CAGETcx-07fGeAxXzD6Lo79XG-0OXJS8wzHztw4_72m2rO9Hpcw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Mar 7, 2019, 3:00 AM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > -     ltpuser = SAFE_GETPWNAM(username);
> > -     uid = ltpuser->pw_uid;
> > +     if (!tst_run_cmd(cmd_useradd, NULL, NULL, 1)) {
> > +             user_added = 1;
> > +             ltpuser = SAFE_GETPWNAM(username);
> > +             uid = ltpuser->pw_uid;
> > +     }
>
> The only thing that I don't like here is that we do not check the cause
> of failure here. What exactly happens on android, is useradd missing
> there completely?


Correct, useradd is missing.

If so we should proceed with TCONF only if
> tst_run_cmd() returned 255 and TBROK the test on other non-zero return
> values.
>

But is the test that's broken if useradd fails for wherever reason? Isn't
it a configuration issue?

Thanks,
Saravana
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190307/b2e08468/attachment.html>
