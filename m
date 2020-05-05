From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 5 May 2020 15:17:24 +0200
Subject: [LTP] [PATCH 1/2] Add test for CVE 2016-8655
In-Reply-To: <20200505102456.13004-1-mdoucha@suse.cz>
References: <20200505102456.13004-1-mdoucha@suse.cz>
Message-ID: <20200505131724.GA21884@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Both patches LGTM.

gcc 4 from CentOS 6 strikes again:

https://travis-ci.org/github/pevik/ltp/jobs/683350147
setsockopt06.c: In function 'thread_run':
setsockopt06.c:55: error: variable 'req' has initializer but incomplete type
setsockopt06.c:56: error: unknown field 'tp_block_size' specified in initializer
setsockopt06.c:56: warning: excess elements in struct initializer
setsockopt06.c:56: warning: (near initialization for 'req')
setsockopt06.c:57: error: unknown field 'tp_block_nr' specified in initializer
setsockopt06.c:57: warning: excess elements in struct initializer
setsockopt06.c:57: warning: (near initialization for 'req')
setsockopt06.c:58: error: unknown field 'tp_frame_size' specified in initializer
setsockopt06.c:58: warning: excess elements in struct initializer
setsockopt06.c:58: warning: (near initialization for 'req')
setsockopt06.c:59: error: unknown field 'tp_frame_nr' specified in initializer
setsockopt06.c:59: warning: excess elements in struct initializer
setsockopt06.c:59: warning: (near initialization for 'req')
setsockopt06.c:60: error: unknown field 'tp_retire_blk_tov' specified in initializer
setsockopt06.c:61: warning: excess elements in struct initializer
setsockopt06.c:61: warning: (near initialization for 'req')
setsockopt06.c:55: error: storage size of 'req' isn't known
setsockopt06.c:55: warning: unused variable 'req'
setsockopt06.c: In function 'run':
setsockopt06.c:84: error: 'TPACKET_V3' undeclared (first use in this function)
setsockopt06.c:84: error: (Each undeclared identifier is reported only once
setsockopt06.c:84: error: for each function it appears in.)

both tests need this definition, which is already in setsockopt02.c.

#ifndef HAVE_STRUCT_TPACKET_REQ3
# define TPACKET_V3 2

struct tpacket_req3 {
	unsigned int	tp_block_size;
	unsigned int	tp_block_nr;
	unsigned int	tp_frame_size;
	unsigned int	tp_frame_nr;
	unsigned int	tp_retire_blk_tov;
	unsigned int	tp_sizeof_priv;
	unsigned int	tp_feature_req_word;
};
#endif

I wanted to propose after release dropping gcc 4 support by deleting CentOS 6
from Travis (but maybe we should drop it even now). To keep the support, it'd be
good to add lapi/if_packet.h with this definition.

Kind regards,
Petr
