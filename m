From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 18 Nov 2020 08:54:31 +0100
Subject: [LTP] [PATCH 0/1] overcommit_memory: Remove unstable subtest
In-Reply-To: <87zh3gnod3.fsf@suse.de>
References: <20201116130915.18264-1-lkml@jv-coder.de> <875z64pc1r.fsf@suse.de>
 <648d7b53-2451-718b-6736-e6dffd4c72e8@jv-coder.de>
 <873618p7ns.fsf@suse.de>
 <0d2a3cc5-e257-ebc5-1488-2a186411d8ad@jv-coder.de> <87zh3gnod3.fsf@suse.de>
Message-ID: <2ff51aa8-a017-35b2-5fd3-87f1483a62cb@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I did some experiments and made the per cpu counters visible. Then I 
realized kernel developers are not that stupid ;)
The per cpu counters can only grow up to batch size and down to negative 
batch size, then they are flushed back to the global counter.

That means the counter seen by __vm_enough_memory can only be off in the 
interval [-numcpu * batch_size, numcpu * batch_size]. So the test can be 
fixed by trying to allocate commit_left + numcpu * batch_size.
Now the only problem is, that the batch size is not visible to 
userspace, so has to be calculated. It depends on the number of cpus and 
total memory pages:
max(ncpus*2, 32, min(int32_max, ram_pages / ncpus / 256) = batch_size 
(in pages)

I guess we can determine these two values from userspace and add the 
batch size to commit_left.
I will prepare a new patch with this approach.

J?rg
