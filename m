From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 May 2016 17:59:51 +0200
Subject: [LTP] LTP Release
In-Reply-To: <20160503124652.GD6059@rei.lan>
References: <20160503124652.GD6059@rei.lan>
Message-ID: <20160509155951.GA1783@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've just pushed last two patches, the fix for isofs and one obvious fix
for netns_netlink.c that causes the test exit with reasonable error
rather than fail silently in recv().

I do not want to delay the release anymore, since we are quite late
anyway. Is there something that absolutely must be part of the release
or can I proceed with the release procedure tomorrow?

-- 
Cyril Hrubis
chrubis@suse.cz
