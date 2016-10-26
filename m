From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 26 Oct 2016 12:26:14 +0200
Subject: [LTP] [PATCH v2] readahead02: estimate max readahead size
In-Reply-To: <21e428ec65f26ea5dc755f0a1e3785e040557e36.1477468318.git.jstancek@redhat.com>
References: <21e428ec65f26ea5dc755f0a1e3785e040557e36.1477468318.git.jstancek@redhat.com>
Message-ID: <20161026102613.GA17833@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Tested-by: Cyril Hrubis <chrubis@suse.cz>
Acked-by: Cyril Hrubis <chrubis@suse.cz>

We should also note in the patch changelog that this fixes the test on
Btrfs, where it wasn't working previously since there is no
/sys/dev/block/$major:$minor/ for the anonymous block devices that are
used internaly for subvolumes.

-- 
Cyril Hrubis
chrubis@suse.cz
