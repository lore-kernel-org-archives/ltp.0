From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 May 2016 18:12:11 +0200
Subject: [LTP] LTP Release
In-Reply-To: <20160509155951.GA1783@rei.suse.cz>
References: <20160503124652.GD6059@rei.lan> <20160509155951.GA1783@rei.suse.cz>
Message-ID: <20160509161211.GB1783@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I've just pushed last two patches, the fix for isofs and one obvious fix
> for netns_netlink.c that causes the test exit with reasonable error
> rather than fail silently
                           ^ in system() then later fail in recv()
-- 
Cyril Hrubis
chrubis@suse.cz
