From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 26 Sep 2018 16:48:16 +0200
Subject: [LTP] [PATCH v2] statx: fix compile errors
In-Reply-To: <20180926141545.3396-1-cascardo@canonical.com>
References: <20180919044813.22875-1-liwang@redhat.com>
 <20180926141545.3396-1-cascardo@canonical.com>
Message-ID: <20180926144816.GA5524@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> struct statx is only defined in sys/stat.h when _GNU_SOURCE is defined.
> The testcases do define _GNU_SOURCE, but not the m4 struct check.

Ah, that is the missing bit, good catch, applied.

-- 
Cyril Hrubis
chrubis@suse.cz
