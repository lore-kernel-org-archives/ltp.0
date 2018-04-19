From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Apr 2018 18:01:35 +0200
Subject: [LTP] [PATCH] *.py : convert python2 to python3
In-Reply-To: <20180419101038.22451-1-yosun@suse.com>
References: <20180419101038.22451-1-yosun@suse.com>
Message-ID: <20180419160135.GB13045@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Looks good but shouldn't we update hashbangs to python3 since these
changes effectively make the code python3 only?

Also there is execltp.in that is written in python, have you looked at
that source? Is that one python3 compatible?

-- 
Cyril Hrubis
chrubis@suse.cz
