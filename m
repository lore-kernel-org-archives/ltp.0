From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 May 2019 16:17:50 +0200
Subject: [LTP] [PATCH 2/2] libltpnuma: remove restrictions on numa
	node-id
In-Reply-To: <20190508052318.9020-3-liwang@redhat.com>
References: <20190508052318.9020-3-liwang@redhat.com>
Message-ID: <20190514141750.GC1516@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
This is obviously OK, applied, thanks for the fix.

I guess that later on we may replace the check by storing the maximal
numa node to the numa mapping structure and check that the id is <= than
the max node.

-- 
Cyril Hrubis
chrubis@suse.cz
