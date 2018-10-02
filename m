From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Oct 2018 14:51:17 +0200
Subject: [LTP] [RFC] Unique test case ids in runtest files ?
In-Reply-To: <1536849882-28897-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1536849882-28897-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20181002125117.GD24796@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I.e. if we run LTP with the default scenario then
>  1) most of the test cases above are executed twice.

This is problem that would be hard to fix. We would have to rethink how
we organize testcases in the runtest files in the long term to
completely avoid situations like this.

>  2) keyctl01, sysctl01, unshare01 are executed twice.
>     Each time they actually point to a different binary/command.

This is a bug that has to be fixed.

-- 
Cyril Hrubis
chrubis@suse.cz
