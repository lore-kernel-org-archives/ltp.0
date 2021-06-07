From: Michal Hocko <mhocko@suse.com>
Date: Mon, 7 Jun 2021 10:10:08 +0200
Subject: [LTP] [mm/mempolicy]  7463fff037: ltp.mbind01.fail
In-Reply-To: <20210607074815.GC16270@xsang-OptiPlex-9020>
References: <1622560492-1294-3-git-send-email-feng.tang@intel.com>
 <20210607074815.GC16270@xsang-OptiPlex-9020>
Message-ID: <YL3UYOGIz1HoqGd1@dhcp22.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon 07-06-21 15:48:15, kernel test robot wrote:
> mbind01.c:169: TINFO: case MPOL_PREFERRED (no target)
> mbind01.c:188: TFAIL: Wrong policy: 1, expected: 4

AFAIU this points to
static void test_none(unsigned int i, char *p)
{
        struct test_case *tc = &tcase[i];

        TEST(mbind(p, MEM_LENGTH, tc->policy, NULL, 0, tc->flags));
}

So it calls MPOL_PREFERRED with NULL parameter and the test has failed
because the kernel returns MPOL_LOCAL instead of MPOL_PREFERRED. Strictly
speaking this is breaking user interface but I am wondering whether this
really matter or is completely unexpected.  The manual page explicitly
talks about this case
"
	If the nodemask and maxnode arguments specify the empty set, then
	the memory is allocated on the node of the CPU that triggered the
	allocation.
"

I would be inclined to keep this inconsistency and see whether anybody
actually complains and have a relevant use for this behavior. The
cleanup which makes the code easier to maintain and less error prone
doesn't really deserve to get ditched just because of this IMHO.
-- 
Michal Hocko
SUSE Labs
