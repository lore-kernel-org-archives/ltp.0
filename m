Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MA0gA-0004Hs-V5
	for ltp-list@lists.sourceforge.net; Fri, 29 May 2009 11:55:18 +0000
Received: from an-out-0708.google.com ([209.85.132.248])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MA0gA-0006dn-1a
	for ltp-list@lists.sourceforge.net; Fri, 29 May 2009 11:55:18 +0000
Received: by an-out-0708.google.com with SMTP id d11so3252049and.37
	for <ltp-list@lists.sourceforge.net>;
	Fri, 29 May 2009 04:55:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A1118E9.1000501@yahoo.fr>
References: <4A1067FE.8080501@yahoo.fr> <4A1118E9.1000501@yahoo.fr>
Date: Fri, 29 May 2009 04:55:16 -0700
Message-ID: <364299f40905290455i72933ecfxe7a40beb8687899c@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] LTP cross compilation
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
To: Hichem Boussetta <boussettahichem@yahoo.fr>
Cc: ltp-list@lists.sourceforge.net

On Mon, May 18, 2009 at 1:14 AM, Hichem Boussetta
<boussettahichem@yahoo.fr> wrote:
> Hichem Boussetta a =E9crit :
>>
>> Hi all,
>>
>> It is the first time that I use ltp and I am having some troubles trying
>> to cross compile it.
>> I have seen a cross compilation example in the installation manual. It is
>> about cross compiling for a powerpc processor.
>>
>> CROSS_COMPILER=3D/opt/ppc64/powerpc64-linux/bin/powerpc64-linux-
>> CROSS_CFLAGS=3D -mpowerpc64
>> LDFLAGS=3D-static
>> LOADLIBES=3D-lpthread -lc -lresolv -lnss_dns -lnss_files -lm -lc
>> LIB_DIR=3D/lib64
>> export LOADLIBES LIB_DIR
>>
>> In my case, I a compiling for an arm processor. I tried to do the same by
>> the specifying the toolchain prefix, the CC, LD, AR and the LIB_DIR. But=
, I
>> get always this error when cross compiling :
>>
>> getdelays.c: In function 'print_delayacct':
>> getdelays.c:215: error: 'struct taskstats' has no member named
>> 'freepages_count'
>> getdelays.c:216: error: 'struct taskstats' has no member named
>> 'freepages_delay_total'
>> make[5]: *** [getdelays] Erreur 1
>>
>> In fact, I omitted the libraries nss_dns and lnss_files since didn't find
>> them in the lib directories of my toolchain. I am not sure about that, b=
ut I
>> don't think the problem is related to this libraries since they do not e=
xist
>> in my host machine either, and here, the compilation of ltp worked well.
>> Perhaps, the problem is due to the fact that I didn't put any option in =
the
>> CROSS_CFLAGS since I found nowhere how to get this information.
>>
>> If someone knows any thing about this or succeeded to cross compile ltp,
>> it would be really nice if he could tell me, because I am really stuck n=
ow
>> :-)
>>
>> Thanks,
>>
> Hi all,
>
> I think that I've figured out how to configure LTP for cross
> compilation. In fact, we need to put the right parameters during the
> configuration. We should append the cross toolchain's bin directory to
> the path and add --host=3D$(toolchain_prefix) to the configure script. By
> doing that, ltp succeds to find out the binary utilities that it should
> use (gcc, ld ,ar, ranlib, ...). We should also specify the path to the
> include and lib directory of the toolchain we are using by setting the
> variables CPPFLAGS and LDFLAGS. However, I still get a compilation error
> that I think it is related to the fact that some libraries are missing
> (signalfd for example). The message I receive is this :
>
> getdelays.c: In function 'print_delayacct':
> getdelays.c:215: error: 'struct taskstats' has no member named
> 'freepages_count'
> getdelays.c:216: error: 'struct taskstats' has no member named
> 'freepages_delay_total'
>
> Does anyone know how to overcome this problem or does this mean that it
> is not possible to cross compile LTP ? In fact, the crosstoolchains I am
> using are generated using crosstool-ng. So, I don't think that the
> problem is due to the toolchain.

Your code may be mismatched with the testcode which means the autoconf
stuff needs to be fixed.
-Garrett

---------------------------------------------------------------------------=
---
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT =

is a gathering of tech-side developers & brand creativity professionals. Me=
et
the minds behind Google Creative Lab, Visual Complexity, Processing, & =

iPhoneDevCamp as they present alongside digital heavyweights like Barbarian =

Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
