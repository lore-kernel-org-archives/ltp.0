From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 4 Jan 2021 11:40:53 +0100
Subject: [LTP] Query: LTP CVE test cherry picking
In-Reply-To: <BM1PR01MB3825BDAFB8CB55CA9C46F1D8EEDE0@BM1PR01MB3825.INDPRD01.PROD.OUTLOOK.COM>
References: <BM1PR01MB3825BDAFB8CB55CA9C46F1D8EEDE0@BM1PR01MB3825.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <X/LwtaAuxYlP+/m8@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I know LTP covers CVE tests but i want to know does LTP covers all CVE
> tests, how  LTP cherry picks it ??

There is not much to cherry pick. We write tests for CVEs if it's
feasible. That usually means that there is a public reproducer for the
CVE that could be turned into automated testcase, which is not always
the case.

We are sometimes notified about such cases by developers that are
working on security and it usually ends up as a github issue. We do have
a few of these there with a tag "reproducer" with a link to reproducer
and description. These issues then hangs in the issue until someone has
time to work on that.

To sum it up, implementation of CVE testcases in LTP is best effort and
we are trying to cover as much as possible with the manpower we have.

-- 
Cyril Hrubis
chrubis@suse.cz
