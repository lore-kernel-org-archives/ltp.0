From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 29 Aug 2017 13:22:11 +0200
Subject: [LTP] [PATCH v2 2/2] android: getcwd02: use temp dir from
 $TMPDIR if present
In-Reply-To: <20170828164043.93407-3-sspatil@google.com>
References: <20170828164043.93407-1-sspatil@google.com>
 <20170828164043.93407-3-sspatil@google.com>
Message-ID: <20170829112211.GC31839@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a minor change, thanks.

I got rid of the GETCWD_TMPDIR_PATH macro, we use the string only in a
single place so there is no need to define it.

-- 
Cyril Hrubis
chrubis@suse.cz
