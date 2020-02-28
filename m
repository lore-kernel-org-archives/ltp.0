From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 28 Feb 2020 10:55:25 +0100
Subject: [LTP] [PATCH 4/4] doc: Update style guide to new API
In-Reply-To: <513439094.9393483.1582881728087.JavaMail.zimbra@redhat.com>
References: <20200227163922.317-1-pvorel@suse.cz>
 <20200227163922.317-4-pvorel@suse.cz>
 <CAEemH2ddNJTjzvPgHvtwVTM0CeFYH2_wy7SeK90ZPDMvME9K5g@mail.gmail.com>
 <20200228084236.GA4925@dell5510>
 <513439094.9393483.1582881728087.JavaMail.zimbra@redhat.com>
Message-ID: <20200228095525.GA11177@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> > You often quote the style guide. What do you suggest?
> > Keep it or delete and move some of it's content to Test-Writing-Guidelines?
> > (which ones)?

> I'm fine with removing it, and move what's not covered to other docs.
Thanks for your ack.
To be honest I don't see much things left.
"Fixing Open Posix Testsuite" paragraph is not covered anywhere, but I wouldn't
care (not really sure where to put this + IMHO I'd prefer this project to be on
it's own).

For things like "Inline assigments" we get compiler warnings.

Maybe "System headers" note is worth. But actually, even this is outdated:
IMHO would be better to advice use our lapi headers (adding paragraph to
"2.2.1 Basic test structure"

Kind regards,
Petr
