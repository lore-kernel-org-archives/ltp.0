From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 8 Sep 2016 11:16:25 +0200
Subject: [LTP] [PATCH V2 4/6] memcg_function_test.sh: Split
In-Reply-To: <57D12B0F.802@oracle.com>
References: <1473089055-17782-1-git-send-email-chrubis@suse.cz>
 <1473089055-17782-4-git-send-email-chrubis@suse.cz>
 <57D12B0F.802@oracle.com>
Message-ID: <20160908091625.GA20976@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +################################################################################
> > +##                                                                            ##
> > +## Copyright (c) 2009 FUJITSU LIMITED                                         ##
> > +##                                                                            ##
> > +## This program is free software;  you can redistribute it and#or modify      ##
> > +## it under the terms of the GNU General Public License as published by       ##
> > +## the Free Software Foundation; either version 2 of the License, or          ##
> > +## (at your option) any later version.                                        ##
> > +##                                                                            ##
> > +## This program is distributed in the hope that it will be useful, but        ##
> > +## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> > +## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> > +## for more details.                                                          ##
> > +##                                                                            ##
> > +## You should have received a copy of the GNU General Public License          ##
> > +## along with this program;  if not, write to the Free Software Foundation,   ##
> > +## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
> > +##                                                                            ##
> > +## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
> > +## Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>                     ##
> > +## Added memcg enable/disable functinality: Rishikesh K Rajak		      ##
> > +##						<risrajak@linux.vnet.ibm.com  ##
> > +##                                                                            ##
> > +################################################################################
> > +
> > +TCID="memcg_subgroup_charge"
> > +TST_TOTAL=3
> > +
> > +. memcg_lib.sh
> > +
> > +# Case 36 - 38: Test that group and subgroup have no relationship
> > +testcase_36()
> > +{
> > +	test_subgroup $PAGESIZE $((2*PAGESIZE))
> > +}
> > +
> > +testcase_37()
> > +{
> > +	test_subgroup $PAGESIZE $PAGESIZE
> > +}
> > +
> > +testcase_38()
> > +{
> > +	test_subgroup $PAGESIZE 0
> > +}
> 
> I believe you've missed my comment for V1 about the numbering scheme here:
> 
> [root@skholman-m7 ltp]# ./testcases/bin/memcg_subgroup_charge.sh
> memcg_subgroup_charge 1 TINFO : Starting test 1
> /opt/ltp/testcases/bin/memcg_lib.sh: line 536: testcase_1: command not found
> memcg_subgroup_charge 1 TINFO : Starting test 2
> /opt/ltp/testcases/bin/memcg_lib.sh: line 536: testcase_2: command not found
> memcg_subgroup_charge 1 TINFO : Starting test 3
> /opt/ltp/testcases/bin/memcg_lib.sh: line 536: testcase_3: command not found
> [root@skholman-m7 ltp]#

My bad, the test is broken that way.


BTW part of the problem is that the shell library reports TPASS even if
the test haven't reported any results so this is hidden until you check
the logs. I guess that we should turn the bitflags to counters in
test.sh and actually check that the test reported something at the end.

-- 
Cyril Hrubis
chrubis@suse.cz
