From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Sep 2020 11:33:29 +0200
Subject: [LTP] [PATCH v2 1/1] fanotify10: Skip non zero ignored_onchild
 tests for < v5.9
In-Reply-To: <CAOQ4uxjUj35ePAzQuEO6BrTskrrp0TLX-tnV7L4Opcda0Mm8gg@mail.gmail.com>
References: <20200911065124.18992-1-pvorel@suse.cz>
 <CAOQ4uxjUj35ePAzQuEO6BrTskrrp0TLX-tnV7L4Opcda0Mm8gg@mail.gmail.com>
Message-ID: <20200911093329.GA7459@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> On Fri, Sep 11, 2020 at 9:51 AM Petr Vorel <pvorel@suse.cz> wrote:

> > ignored mask in combination with flag FAN_EVENT_ON_CHILD has
> > undefined behavior on kernel < 5.9.

> > Also remove wrong kernel commit (left in e8189ff3c).

> > Acked-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Thanks!

...
> > - * Test cases #17-#23 are regression tests for commit:
> > + * Test cases #17-#23 are regression tests for commit (from v5.9, unlikely to be
> > + * backported thus not in .tags):

> If we are being accurate, it is only the 4 test cases with non zero
> ignored_onchild
> that are regression tests for this commit. The other 3 test cases are
> just completing
> the test matrix of possible combinations of marks.

> So you may rephrase above as "Test cases with 'ignored_onchild'..."
> or what not.
Good point, I'll fix it before merge.

Kind regards,
Petr
