From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Jun 2021 15:40:56 +0200
Subject: [LTP] [PATCH] ltp-aiodio: help aiodio test work normally
In-Reply-To: <20210602182625.GJ2978781@localhost.localdomain>
References: <20210601155427.996321-1-zlang@redhat.com> <YLdwYJ3Kw5qf64d2@yuki>
 <20210602182625.GJ2978781@localhost.localdomain>
Message-ID: <YLjb6E5+CT3hMC4l@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I do not like this solution. I think that we should instead fix the
> > scripts. I think that the runltp should just export TMPDIR if it was
> > passed on commandline and it should be the resposibility of the caller
> > to set up a temporary directory somewhere in /tmp in that case.
> 
> Sorry I can't understand your solution, would you like to show me some
> detailed code which can make the aiodio test pass, to explain what do
> you really like to do?

Looking at the testscripts/ltp-aiodio.sh it calls ltp-pan directly so
runltp is not involved at all. I guess that the simple solution here
would be exporting correct TMPDIR so that it points to the
"$TMP/aiodio".

From the testcase viewpoint TMPDIR always was the path where the test
should create files.

-- 
Cyril Hrubis
chrubis@suse.cz
