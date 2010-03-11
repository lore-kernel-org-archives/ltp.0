Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NpZoZ-0001Q4-6r
	for ltp-list@lists.sourceforge.net; Thu, 11 Mar 2010 04:16:03 +0000
Received: from mail-iw0-f176.google.com ([209.85.223.176])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NpZoW-0000Xf-JA
	for ltp-list@lists.sourceforge.net; Thu, 11 Mar 2010 04:16:02 +0000
Received: by iwn6 with SMTP id 6so5638140iwn.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 10 Mar 2010 20:15:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B97AA99.7050406@in.ibm.com>
References: <4B97AA99.7050406@in.ibm.com>
Date: Wed, 10 Mar 2010 20:15:55 -0800
Message-ID: <364299f41003102015j42667189x9adbc23f48121e87@mail.gmail.com>
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
Cc: ltp-list@lists.sourceforge.net, serue@linux.vnet.ibm.com

On Wed, Mar 10, 2010 at 6:20 AM, Sachin Sant <sachinp@in.ibm.com> wrote:
> NETNS tests from containers fails to execute with following
> message
>
> Running netns tests.
> --: childns.sh '/opt/ltp': No such file or directory
>
> Looking at the code the problem could be with create_net_namespace()
> within netns/common.c
>
> If i make the following changes the first subtest works fine but then
> i ran into other failures related to other sub tests.
>
> @@ -92,7 +92,7 @@ int create_net_namespace(char *p1, char
> =A0 =A0 =A0 }
>
> =A0 =A0 =A0 /* We need to pass the child pid to the parentns.sh script */
> - =A0 =A0 =A0 sprintf(par, "parentns.sh '%s' %s %" PRId32 , ltproot, p1, =
pid);
> + =A0 =A0 =A0 sprintf(par, "%s/testcases/bin/parentns.sh %s %" PRId32 , l=
tproot,
> p1, pid);
>
> =A0 =A0 =A0 ret =3D system(par);
> =A0 =A0 =A0 status =3D WEXITSTATUS(ret);
> @@ -141,7 +141,7 @@ int child_fn(void *c1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit(1);
> =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 sprintf(child, "childns.sh '%s'", ltproot);
> + =A0 =A0 =A0 sprintf(child, "%s/testcases/bin/childns.sh", ltproot);
>
> As i don't know the code too much .. i am not sure how to fix it.

export PATH=3D$PATH:$LTPROOT/testcases/bin ; parentns.sh ?

Why are you overcomplicating things by hardcoding the path again?
That's the exact reason why it was removed in the first place...

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
