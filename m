From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Jan 2017 12:57:13 +0100
Subject: [LTP] [PATCH v2 4/4] ltp/numa: add new test11
In-Reply-To: <1481710151-18453-1-git-send-email-liwang@redhat.com>
References: <1481710151-18453-1-git-send-email-liwang@redhat.com>
Message-ID: <20170119115713.GA9193@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've pushed all patches but this one (thanks!) as I added a few more
fixes for the testcase as well. The most important is the one that makes
the numa01.sh script wait util the helper allocates memory instead of
sleeping and hoping for the best.

Can you please update this patch so that the newly added test matches
the changes I did to the rest of the testcases?

-- 
Cyril Hrubis
chrubis@suse.cz
