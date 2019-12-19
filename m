From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 19 Dec 2019 08:08:45 +0100
Subject: [LTP] [PATCH v2 2/2] network/iptables: add new test for
 iptables-tranlsate and nft
In-Reply-To: <853a8441-efc3-03e2-4889-1421cbe976b5@oracle.com>
References: <20191217171918.10237-1-alexey.kodanev@oracle.com>
 <20191217171918.10237-2-alexey.kodanev@oracle.com>
 <20191218084406.GA10966@dell5510>
 <f0aad696-82a5-fb06-0517-a437d95ae2e7@oracle.com>
 <20191218152832.GA26689@dell5510>
 <853a8441-efc3-03e2-4889-1421cbe976b5@oracle.com>
Message-ID: <20191219070845.GA25978@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > BTW even more setup could be moved into iptables_lib.sh.
> > If you like this change, I can push it.

> No objections. I thought it is better to keep these TST_*
> variables per test, in the header, rather than searching
> in the lib... but looks like it might save some duplication.

The main reason for me to move TST_* variables into library is to keep code
together, where it's used.
The downside of it is that these variables may be accidentally overwritten by
setup in test. That's why I used default values, which can be overwritten in
if-lib.sh.

I'll send a patch, feel free to not ack that (agree, that it's a syntax
optimization, the test itself is what matters).

Kind regards,
Petr
