Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jjaburek@redhat.com>) id 1XS60U-0008No-47
	for ltp-list@lists.sourceforge.net; Thu, 11 Sep 2014 15:09:58 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XS60R-0007zO-8a
	for ltp-list@lists.sourceforge.net; Thu, 11 Sep 2014 15:09:58 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s8BF9mhS027007
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Sep 2014 11:09:48 -0400
Message-ID: <5411BB3A.70308@redhat.com>
Date: Thu, 11 Sep 2014 17:09:46 +0200
From: Jiri Jaburek <jjaburek@redhat.com>
MIME-Version: 1.0
References: <1409047170-18251-1-git-send-email-mmarhefk@redhat.com>	<1409319967-12730-1-git-send-email-mmarhefk@redhat.com>
	<1803448098.18473481.1409840011670.JavaMail.zimbra@redhat.com>
In-Reply-To: <1803448098.18473481.1409840011670.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH 1/2 v2] containers: added mountns/mountns03.c
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Matus Marhefka <mmarhefk@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 09/04/2014 04:13 PM, Jan Stancek wrote:
> 
> 
> 
> 
> ----- Original Message -----
>> From: "Matus Marhefka" <mmarhefk@redhat.com>
>> To: ltp-list@lists.sourceforge.net
>> Sent: Friday, 29 August, 2014 3:46:07 PM
>> Subject: [LTP] [PATCH 1/2 v2] containers: added mountns/mountns03.c
>>
>> * Tests a slave mount: slave mount is like a shared mount except that
>>   mount and umount events only propagate towards it
>>
>> Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
>> ---
>>  runtest/containers                              |   1 +
>>  testcases/kernel/containers/.gitignore          |   1 +
>>  testcases/kernel/containers/mountns/mountns03.c | 245
>>  ++++++++++++++++++++++++
>>  3 files changed, 247 insertions(+)
>>  create mode 100644 testcases/kernel/containers/mountns/mountns03.c
>>
>> diff --git a/runtest/containers b/runtest/containers
>> index 56977c0..3653c9c 100644
>> --- a/runtest/containers
>> +++ b/runtest/containers
>> @@ -58,3 +58,4 @@ utstest_clone_5 utstest clone 5
>>  
>>  mountns01 mountns01
>>  mountns02 mountns02
>> +mountns03 mountns03
>> diff --git a/testcases/kernel/containers/.gitignore
>> b/testcases/kernel/containers/.gitignore
>> index f175296..5b96cb9 100644
>> --- a/testcases/kernel/containers/.gitignore
>> +++ b/testcases/kernel/containers/.gitignore
>> @@ -1,3 +1,4 @@
>>  /check_for_unshare
>>  mountns/mountns01
>>  mountns/mountns02
>> +mountns/mountns03
>> diff --git a/testcases/kernel/containers/mountns/mountns03.c
>> b/testcases/kernel/containers/mountns/mountns03.c
>> new file mode 100644
>> index 0000000..acca44c
>> --- /dev/null
>> +++ b/testcases/kernel/containers/mountns/mountns03.c
>> @@ -0,0 +1,245 @@
>> +/* Copyright (c) 2014 Red Hat, Inc.
>> + *
>> + * This program is free software: you can redistribute it and/or modify
>> + * it under the terms of version 2 the GNU General Public License as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + ***********************************************************************
>> + * File: mountns03.c
>> + *
>> + * Tests a slave mount: slave mount is like a shared mount except that
>> + * mount and umount events only propagate towards it.
>> + * Description:
>> + * 1. Creates directories "A", "B", "C", "D" and files "A/A", "B/B"
>> + *    "C/C", "D/D"
>> + * 2. Unshares mount namespace and makes it private (so mounts/umounts
>> + *    have no effect on a real system)
> 
> Hi,
> 
>> + * 3. Bind mounts directory "A" to "A" and "B" to "B"
> 
> is the "B" to "B" part necessary in this case? First thing child does is
> it mounts A to B.
> 
>> + * 4. Makes both directories ("A" and "B") shared
> 
> related to above, is it necessary to make B shared?

The obvious answer would be "yes", because mount namespaces work with
mount points - if you create a mountpoint, make it shared and *then*
create a new namespace, both namespaces are going to share that mount
point and any change to it (ie. bind mount over it) is going to be
"propagated" to both (or all namespaces that share it).

This is in contrast with slave mountpoints, which only "receive"
propagation events, not "send" them to other namespaces.

The logic however doesn't end there, a mountpoint can be both "shared"
and "slave" at the same time, essentially "receiving" propagation events
from one group of namespaces and "sending" local propagation events to
a different group.

However as the test logic is not really simple, I don't know if bind
mounting "B" is in fact necessary for this test case, meaning the
answer is not obvious (see also further below).


I guess it could be simplified and extended by the "slave + shared" case
like ie.:

(the following expects A and B to be directories, with A bind-mounted
to itself, creating a mount point, made private, with A having file
a and B having file b, essentially A/a and B/b)
(also, X, Y and Z are namespaces)

To set-up:

  private:
    X) create Y

  shared:
    X) make A shared
    X) create Y

  slave:
    X) make A shared
    X) create Y
    Y) make A slave

  slave-shared:
    X) make A shared
    X) create Y
    Y) make A slave
    Y) make A shared
    Y) create Z

To test/verify:

  private:
    X) bind mount B over A
    Y) see A/a
    X) umount A
    AND
    Y) bind mount B over A
    X) see A/a
    Y) umount A

  shared:
    X) bind mount B over A
    Y) see A/b
    X) umount A
    AND
    Y) bind mount B over A
    X) see A/b
    Y) umount A

  slave:
    X) bind mount B over A
    Y) see A/b
    X) umount A
    AND
    Y) bind mount B over A
    X) see A/a  # slave cannot propagate up (to master)
    Y) umount A

  slave-shared:
    X) bind mount B over A
    Y) see A/b
    Z) see A/b
    X) umount
    AND
    Y) bind mount B over A
    X) see A/a  # slave cannot propagate up
    Z) see A/b  # Z shares A with Y
    Y) umount A
    AND
    Z) bind mount B over A
    X) see A/a  # slave cannot propagate up
    Y) see A/b  # Y shares A with Z
    Z) umount A

This could be continued with ie. slave-shared-slave (by making A slave
in Z), but that wouldn't exercise any new code paths.

See also the state/transition diagrams in the kernel docs,
Documentation/filesystems/sharedsubtree.txt


On 08/29/2014 03:46 PM, Matus Marhefka wrote:
> + * 1. Creates directories "A", "B", "C", "D" and files "A/A", "B/B"
> + *    "C/C", "D/D"
> + * 2. Unshares mount namespace and makes it private (so mounts/umounts
> + *    have no effect on a real system)
> + * 3. Bind mounts directory "A" to "A" and "B" to "B"
> + * 4. Makes both directories ("A" and "B") shared
> + * 5. Clones a new child process with CLONE_NEWNS flag - the new child
> + *    then:
> + *    a) bind mounts directory "A" to directory "B"
> + *    b) makes mount "B" a slave of "A"
> + *    c) bind mounts directory "C" to "A"
> + *    d) checks that mount in c) propagated also to direcoty "B" (as "B"
> + *       is a slave of "A"):

So you're checking slave propagation within the same (child) namespace?
I guess it makes sense, since it should work on mountpoints in general,
but then how do you "make mount B a slave of A" without a namespace
switch? Doing MS_SLAVE on a MS_SHARED mountpoint with a single member in
the peer group (no master) makes it MS_PRIVATE automatically.
Does the parent process here serve as a placeholder to prevent that?

> + *       - if it does, test #1 passes
> + *       - if it doesn't, test #1 fails
> + *    e) bind mounts direcory "D" to "B"
> + *    f) waits for parent approval to terminate
> + * 6. Parent checks if directory "A" doesn't contain the file "D"
> + *    (as slave mount ("B") doesn't forward propagation (to "A")):
> + *    - if it doesn't, test #2 passes
> + *    - if it does, test #2 fails
> + * 7. Parent allows child to terminate

If I understood it correctly,

     parent | child
----------- +--------
A (shared)  | A (shared)
            | |
            | V
B (shared)  | B (slave)

with the tests being performed on B in the child. This raises a question
- why do you need B at all? Why not do MS_SLAVE on A? In this sense,
B (child) is not a slave of B (parent), but a slave of A (parent), with
B (parent) being slave of A (parent) due to the shared propagation.

(It's why my extended test matrix above doesn't make B a mountpoint,
because all the testing is done on A).

Thanks & feel free to ask,
Jiri


------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
