From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 19 Jul 2017 15:01:09 +0200
Subject: [LTP] [PATCH v3 6/9] Test for CVE-2014-0196 PTY echo race
In-Reply-To: <20170623122211.29575-7-rpalethorpe@suse.com>
References: <20170623122211.29575-1-rpalethorpe@suse.com>
 <20170623122211.29575-7-rpalethorpe@suse.com>
Message-ID: <20170719130108.GH1015@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've added CFLAGS and LDLIBS to the Makefile (since I removed these
while I was fixing the build) and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
