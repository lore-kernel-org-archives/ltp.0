From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 21 Mar 2016 13:09:40 +0100
Subject: [LTP] [PATCH RFC 9/9] ftrace_stress: add two new tests
In-Reply-To: <1617631867.29672478.1458310104811.JavaMail.zimbra@redhat.com>
References: <1457079898-9449-1-git-send-email-liwang@redhat.com>
 <1457079898-9449-5-git-send-email-liwang@redhat.com>
 <1457079898-9449-6-git-send-email-liwang@redhat.com>
 <1457079898-9449-7-git-send-email-liwang@redhat.com>
 <1457079898-9449-8-git-send-email-liwang@redhat.com>
 <1457079898-9449-9-git-send-email-liwang@redhat.com>
 <1457079898-9449-10-git-send-email-liwang@redhat.com>
 <20160317180833.GJ31815@rei.lan>
 <1617631867.29672478.1458310104811.JavaMail.zimbra@redhat.com>
Message-ID: <20160321120939.GA32294@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Thanks for the review. Seems some Bash styles needs to be fixed in all subcase.
> I replied the issues you pointed out below. You mean I need to write a c bin 
> to generate random? Or you will make it in lib?

I think easiest solution would be to add tst_random that takes min and
max parameters to the test.sh and use date to implement it. Just do it
in a separate patch, or if needed I can add it for you.

> I have to ask a question about the portable.Can we use an array here? You
> mean we can't use array or just can't use the ${#array_name} to get the 
> number of elements? If array can be used, I guess I can use something like

Arrays are bash specific feature.

> echo ${triggers[*]} | wc -w , If not accepted by some shells. Then I need to
> change it to string, and use the way you mentioned echo "$string" | wc -w

That would be the best solution.

FYI you can install dash on most of the distributions and try to run the
scripts with it. That will catch most of the portability issues.

...

> > > +	cat $TRACING_PATH/set_ftrace_filter > /dev/null
> > 
> > Why do we cat the file to /dev/null?
> 
> since the set_ftrace_filter can use reg match and support mod.
> such as if I:
> 
> echo :mod:kvm > /sys/kernel/debug/tracing/set_ftrace_filter 
> 
> cat /sys/kernel/debug/tracing/set_ftrace_filter  | head -n 10
> ack_flush [kvm]
> kvm_get_kvm [kvm]
> kvm_disable_largepages [kvm]
> kvm_vcpu_mmap [kvm]
> kvm_io_bus_sort_cmp [kvm]
> mark_page_dirty_in_slot [kvm]
> kvm_sched_out [kvm]
> kvm_vcpu_init [kvm]
> kvm_vcpu_uninit [kvm]
> 
> The log will be rather long, I just concern it will make the log
> too large. You suggest make it show ?

I'm just asking since it looks to me like this statement has no effect
at all. Or are we trying to test that kernel does not break if we read
the file? In that case we should add a short comment with explanation.

> > > +}
> > > diff --git
> > > a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_cpumask.sh
> > > b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_cpumask.sh
> > > new file mode 100755
> > > index 0000000..28bbc27
> > > --- /dev/null
> > > +++
> > > b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_cpumask.sh
> > > @@ -0,0 +1,51 @@
> > > +#! /bin/sh
> > > +
> > > +###########################################################################
> > > +##
> > > ##
> > > +## Copyright (c) 2015, Red Hat Inc.
> > > ##
> > > +##
> > > ##
> > > +## This program is free software: you can redistribute it and/or modify
> > > ##
> > > +## it under the terms of the GNU General Public License as published by
> > > ##
> > > +## the Free Software Foundation, either version 3 of the License, or
> > > ##
> > > +## (at your option) any later version.
> > > ##
> > > +##
> > > ##
> > > +## This program is distributed in the hope that it will be useful,
> > > ##
> > > +## but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > ##
> > > +## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > > ##
> > > +## GNU General Public License for more details.
> > > ##
> > > +##
> > > ##
> > > +## You should have received a copy of the GNU General Public License
> > > ##
> > > +## along with this program. If not, see <http://www.gnu.org/licenses/>.
> > > ##
> > > +##
> > > ##
> > > +## Author: Chunyu Hu <chuhu@redhat.com>
> > > ##
> > > +##
> > > ##
> > > +###########################################################################
> > > +
> > > +nr_cpus=`tst_ncpus`
> > > +
> > > +get_random_value()
> > > +{
> > > +	local max=$1
> > > +	local min=${2:-0}
> > > +	local random=${RANDOM:-$(date +%N)}
> > > +	echo $(( random % max  ))
> > > +}
> > 
> > Well looks like you have implemented portable random function after all
> > although the range does not work at all.
> 
> Hmm, it's not working, agree. So the only portable way is using the
> glibc interfaces. You mean I need to write this with c lib, or you mean
> you will do this? Thanks !

Not really the date +%N would work fine in this case as we do not need
too complicated random generator after all.

-- 
Cyril Hrubis
chrubis@suse.cz
