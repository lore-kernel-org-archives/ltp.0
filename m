From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Nov 2018 16:09:38 +0100
Subject: [LTP] [PATCH] lib/tst_test.sh: don't call _tst_do_exit()
 recursively with tst_brk()
In-Reply-To: <f96d10e9-fb35-fe98-0ab0-3fd0c7891c42@oracle.com>
References: <1542729786-4097-1-git-send-email-alexey.kodanev@oracle.com>
 <20181127090439.GA23733@dell5510>
 <f96d10e9-fb35-fe98-0ab0-3fd0c7891c42@oracle.com>
Message-ID: <20181127150937.GB14077@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> OK, we should add similar "WARNING" from 2.2 section to 2.3, right?

> "WARNING: Calling tst_brk() in test 'cleanup()' does not exit the test as well
> and 'TBROK' is converted to 'TWARN'."

Yes, that'd be enough. Thanks for handling it.


Kind regards,
Petr
