Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NpzN4-0006by-Sj
	for ltp-list@lists.sourceforge.net; Fri, 12 Mar 2010 07:33:22 +0000
Received: from mail-gw0-f47.google.com ([74.125.83.47])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NpzN4-00069a-2j
	for ltp-list@lists.sourceforge.net; Fri, 12 Mar 2010 07:33:22 +0000
Received: by gwj23 with SMTP id 23so361223gwj.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Mar 2010 23:33:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B99CC90.90204@in.ibm.com>
References: <4B97AA99.7050406@in.ibm.com>
	<364299f41003102015j42667189x9adbc23f48121e87@mail.gmail.com>
	<4B99CC90.90204@in.ibm.com>
Date: Thu, 11 Mar 2010 23:33:15 -0800
Message-ID: <364299f41003112333v3c9e5e7wb6160c2c59395b68@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] LTP Containers netns test failure.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Sachin Sant <sachinp@in.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Mar 11, 2010 at 9:09 PM, Sachin Sant <sachinp@in.ibm.com> wrote:
> Garrett Cooper wrote:
>>
>> On Wed, Mar 10, 2010 at 6:20 AM, Sachin Sant <sachinp@in.ibm.com> wrote:
>>
>>>
>>> NETNS tests from containers fails to execute with following
>>> message
>>>
>>> Running netns tests.
>>> --: childns.sh '/opt/ltp': No such file or directory
>>>
>>> Looking at the code the problem could be with create_net_namespace()
>>> within netns/common.c
>>>
>>> If i make the following changes the first subtest works fine but then
>>> i ran into other failures related to other sub tests.
>>>
>>> @@ -92,7 +92,7 @@ int create_net_namespace(char *p1, char
>>> =A0 =A0 =A0}
>>>
>>> =A0 =A0 =A0/* We need to pass the child pid to the parentns.sh script */
>>> - =A0 =A0 =A0 sprintf(par, "parentns.sh '%s' %s %" PRId32 , ltproot, p1=
, pid);
>>> + =A0 =A0 =A0 sprintf(par, "%s/testcases/bin/parentns.sh %s %" PRId32 ,
>>> ltproot,
>>> p1, pid);
>>>
>>> =A0 =A0 =A0ret =3D system(par);
>>> =A0 =A0 =A0status =3D WEXITSTATUS(ret);
>>> @@ -141,7 +141,7 @@ int child_fn(void *c1)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0exit(1);
>>> =A0 =A0 =A0}
>>>
>>> - =A0 =A0 =A0 sprintf(child, "childns.sh '%s'", ltproot);
>>> + =A0 =A0 =A0 sprintf(child, "%s/testcases/bin/childns.sh", ltproot);
>>>
>>> As i don't know the code too much .. i am not sure how to fix it.
>>>
>>
>> export PATH=3D$PATH:$LTPROOT/testcases/bin ; parentns.sh ?
>>
>> Why are you overcomplicating things by hardcoding the path again?
>> That's the exact reason why it was removed in the first place...
>>
>
> Hmm .. i am still not able to execute the test even after exporting the
> PATH.
>
> lp5:/opt/ltp # export LTPROOT=3D/opt/ltp
> lp5:/opt/ltp # export PATH=3D$PATH:$LTPROOT/testcases/bin
> lp5:/opt/ltp # ./runltp -f containers
> ........<SNIP>..........
> <<<test_start>>>
> tag=3DContainers stime=3D1268369850
> cmdline=3D"container_test.sh"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> incrementing stop
> Running netns tests.
> --: childns.sh '/opt/ltp': No such file or directory
>
> I feel the problem is: the code is searching childns.sh in LTPROOT
> directory instead of LTPROOT/testcases/bin

    Please test your claim by calling env in the script -- what happens?
    Something doesn't necessarily add up with the claim.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
