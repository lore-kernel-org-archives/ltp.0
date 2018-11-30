From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 30 Nov 2018 19:18:05 +0100
Subject: [LTP] WIKI updates via git
In-Reply-To: <20181127150937.GB14077@dell5510>
References: <1542729786-4097-1-git-send-email-alexey.kodanev@oracle.com>
 <20181127090439.GA23733@dell5510>
 <f96d10e9-fb35-fe98-0ab0-3fd0c7891c42@oracle.com>
 <20181127150937.GB14077@dell5510>
Message-ID: <20181130181805.GA26705@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > OK, we should add similar "WARNING" from 2.2 section to 2.3, right?

> > "WARNING: Calling tst_brk() in test 'cleanup()' does not exit the test as well
> > and 'TBROK' is converted to 'TWARN'."

> Yes, that'd be enough. Thanks for handling it.
Noticed you pushed the changes, but didn't update wiki.
I did it.

BTW: There is a git repository, which makes it easier to update it:
https://github.com/linux-test-project/ltp.wiki.git
(simple git commit is equivalent of change via web)


Kind regards,
Petr
