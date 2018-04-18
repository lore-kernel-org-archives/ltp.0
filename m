From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 18 Apr 2018 14:13:40 +0200
Subject: [LTP] [PATCH 1/5] SAFE_MACROS: Add
 SAFE_SETREUID()/SAFE_SETREGID()
In-Reply-To: <1521804892-5783-1-git-send-email-xuyang.jy@cn.fujitsu.com>
References: <1521804892-5783-1-git-send-email-xuyang.jy@cn.fujitsu.com>
Message-ID: <20180418121340.GA19992@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've reworked this patch and pushed, thanks.

The main things I've fixed here are:

* Don't add the macros to the old library since as a general rule we
  should not add new functionality there

* Fixed the gid_t and uid_t printing, these are integer types so
  printing them with %p is wrong

-- 
Cyril Hrubis
chrubis@suse.cz
