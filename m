From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 18 Apr 2018 11:58:10 +0200
Subject: [LTP] [PATCH] gitignore: Add some binaries to gitignore
In-Reply-To: <20180418095142.20394-1-schlad@suse.de>
References: <20180418095142.20394-1-schlad@suse.de>
Message-ID: <20180418095810.GB4266@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
These are leftovers after removed testcases.

When we delete a test we also delte the .gitignore entry but the
compiled binary still stays in your compiled tree and 'make clean' does
not remove these either since our build system derives list of binaries
based on the present C sources.

You may want to run 'git clean -i' to get rid of these.

-- 
Cyril Hrubis
chrubis@suse.cz
