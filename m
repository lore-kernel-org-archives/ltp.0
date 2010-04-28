Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1O70OP-0002XQ-1n
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 06:05:05 +0000
Received: from mail-pw0-f46.google.com ([209.85.160.46])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O70OO-0007Nw-16
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 06:05:04 +0000
Mime-Version: 1.0 (Apple Message framework v1078)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <103530624.1121001272433642504.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Date: Tue, 27 Apr 2010 23:04:51 -0700
Message-Id: <8B8139E0-F07A-433D-B38D-30DAB81E3FF5@gmail.com>
References: <103530624.1121001272433642504.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] UTIMENSAT test fails hugely
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6304003538000952878=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Caspar ZHANG <czhang@redhat.com>
Cc: ltp-list <ltp-list@lists.sf.net>


--===============6304003538000952878==
Content-Type: multipart/alternative; boundary=Apple-Mail-1--77768631


--Apple-Mail-1--77768631
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 27, 2010, at 10:47 PM, Caspar ZHANG wrote:

>=20
> ----- "Garrett Cooper" <yanegomi@gmail.com> wrote:
>>=20
>> Almost there :). Some comments:
>>=20
>> +	trap 'trap EXIT; teardown' EXIT
>>=20
>> Should be:
>>=20
>> +	trap 'trap "" EXIT; teardown' EXIT
>=20
> Thanks for the tip :-) If I understood correctly, the EXIT=20
> signal is triggered when the program terminates(like after an
> `exit' command). I find that resetting the signal to original
> disposition and ignoring the signal have the same effect since
> the program is always ready to terminate after finishing the
> handler execution. Thus I think using `trap EXIT', `trap - EXIT'
> and `trap "" EXIT' all work.

The first item is different from the other two. The first one ignores =
the signal (SIG_IGN), whereas the latter two cases reset the handler to =
the default one (SIG_DFL). I prefer the former format, because otherwise =
the signal handlers become reentrable on accident.

>>=20
>> The double quotes tell the shell to ignore all future signals trapped
>> for the EXIT event (from bash(1)'s trap section, but the same also
>> applies for ash(1), which is the predecessor to dash ):
>>=20
>> ...
>>=20
>> 									=
If arg is absent (and  there  is  a
>>              single  sigspec)  or  -,  each  specified signal is
>> reset to its
>>              original disposition (the value it  had  upon  entrance=20=

>> to  the
>>              shell).   If arg is the null string the signal specified
>> by each
>>              sigspec is ignored by the shell and by the commands it=20=

>> invokes.
>>=20
>> ...
>>=20
>> The `set' sed could be like this:
>>=20
>> 	pattern=3D"[[:space:]]*Defaults[[:space:]]*requiretty.*"
>> 	sed -E -i "" -e "s/^($pattern)/#\1/" /etc/sudoers
>>=20
>> The restore sed could be like this:
>>=20
>> 	sed -E -i "" -e "s/^#($pattern)/\1/" /etc/sudoers
>> 	# with $pattern being set like before.
>>=20
>> Don't forget the ^ anchors and the quoting's important :).
>>=20
>>>>=20
>>>> 	You may want to execute the handler before the setup call is
>> invoked
>>>> to ensure that everything done is properly undone in the event of
>> a
>>>> failure during setup.
>>>> 	Also, watch out for cases where a user may have done:
>>>>=20
>>>> # requiretty
>>>>=20
>>>> instead of:
>>>>=20
>>>> requiretty
>>>>=20
>>>> 	It probably would be wise to preserve all leading and trailing
>>>> characters for teardown to avoid inadvertently enabling requiretty
>> in
>>>> sudo.
>>>> 	The EXIT trap handler isn't 100% foolproof, but it protects
>> against
>>>> all but SIGKILL or SIGSTOP from being executed as they're NMIs.

Thanks,
-Garrett=

--Apple-Mail-1--77768631
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; =
"><div><div>On Apr 27, 2010, at 10:47 PM, Caspar ZHANG wrote:</div><br =
class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite"><div><br>----- "Garrett Cooper" &lt;<a =
href=3D"mailto:yanegomi@gmail.com">yanegomi@gmail.com</a>&gt; =
wrote:<br><blockquote type=3D"cite"><br></blockquote><blockquote =
type=3D"cite">Almost there :). Some =
comments:<br></blockquote><blockquote =
type=3D"cite"><br></blockquote><blockquote type=3D"cite">+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>trap =
'trap EXIT; teardown' EXIT<br></blockquote><blockquote =
type=3D"cite"><br></blockquote><blockquote type=3D"cite">Should =
be:<br></blockquote><blockquote type=3D"cite"><br></blockquote><blockquote=
 type=3D"cite">+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>trap 'trap "" EXIT; teardown' EXIT<br></blockquote><br>Thanks for =
the tip :-) If I understood correctly, the EXIT <br>signal is triggered =
when the program terminates(like after an<br>`exit' command). I find =
that resetting the signal to original<br>disposition and ignoring the =
signal have the same effect since<br>the program is always ready to =
terminate after finishing the<br>handler execution. Thus I think using =
`trap EXIT', `trap - EXIT'<br>and `trap "" EXIT' all work.<font =
class=3D"Apple-style-span" color=3D"#000000"><font =
class=3D"Apple-style-span" =
color=3D"#144FAE"><br></font></font></div></blockquote><div><br></div>The =
first item is different from the other two. The first one ignores the =
signal (SIG_IGN), whereas the latter two cases reset the handler to the =
default one (SIG_DFL). I prefer the former format, because otherwise the =
signal handlers become reentrable on accident.</div><div><br><blockquote =
type=3D"cite"><div><blockquote type=3D"cite"><br></blockquote><blockquote =
type=3D"cite">The double quotes tell the shell to ignore all future =
signals trapped<br></blockquote><blockquote type=3D"cite">for the EXIT =
event (from bash(1)'s trap section, but the same =
also<br></blockquote><blockquote type=3D"cite">applies for ash(1), which =
is the predecessor to dash ):<br></blockquote><blockquote =
type=3D"cite"><br></blockquote><blockquote =
type=3D"cite">...<br></blockquote><blockquote =
type=3D"cite"><br></blockquote><blockquote type=3D"cite"><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>If arg is =
absent (and &nbsp;there &nbsp;is &nbsp;a<br></blockquote><blockquote =
type=3D"cite"> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;single &nbsp;sigspec) &nbsp;or &nbsp;-, &nbsp;each &nbsp;specified =
signal is<br></blockquote><blockquote type=3D"cite">reset to =
its<br></blockquote><blockquote type=3D"cite"> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;original disposition (the value it &nbsp;had &nbsp;upon =
&nbsp;entrance <br></blockquote><blockquote type=3D"cite">to =
&nbsp;the<br></blockquote><blockquote type=3D"cite"> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;shell). &nbsp;&nbsp;If arg is the null string the signal =
specified<br></blockquote><blockquote type=3D"cite">by =
each<br></blockquote><blockquote type=3D"cite"> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;sigspec is ignored by the shell and by the commands it =
<br></blockquote><blockquote =
type=3D"cite">invokes.<br></blockquote><blockquote =
type=3D"cite"><br></blockquote><blockquote =
type=3D"cite">...<br></blockquote><blockquote =
type=3D"cite"><br></blockquote><blockquote type=3D"cite">The `set' sed =
could be like this:<br></blockquote><blockquote =
type=3D"cite"><br></blockquote><blockquote type=3D"cite"><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>pattern=3D"[[:space:]]*Defaults[[:space:]]*requiretty.*"<br></block=
quote><blockquote type=3D"cite"><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>sed -E -i "" -e =
"s/^($pattern)/#\1/" /etc/sudoers<br></blockquote><blockquote =
type=3D"cite"><br></blockquote><blockquote type=3D"cite">The restore sed =
could be like this:<br></blockquote><blockquote =
type=3D"cite"><br></blockquote><blockquote type=3D"cite"><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>sed -E -i =
"" -e "s/^#($pattern)/\1/" /etc/sudoers<br></blockquote><blockquote =
type=3D"cite"><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span># with $pattern being set like =
before.<br></blockquote><blockquote =
type=3D"cite"><br></blockquote><blockquote type=3D"cite">Don't forget =
the ^ anchors and the quoting's important =
:).<br></blockquote><blockquote type=3D"cite"><br></blockquote><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote =
type=3D"cite"><br></blockquote></blockquote></blockquote><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>You may =
want to execute the handler before the setup call =
is<br></blockquote></blockquote></blockquote><blockquote =
type=3D"cite">invoked<br></blockquote><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">to =
ensure that everything done is properly undone in the event =
of<br></blockquote></blockquote></blockquote><blockquote =
type=3D"cite">a<br></blockquote><blockquote type=3D"cite"><blockquote =
type=3D"cite"><blockquote type=3D"cite">failure during =
setup.<br></blockquote></blockquote></blockquote><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>Also, =
watch out for cases where a user may have =
done:<br></blockquote></blockquote></blockquote><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote =
type=3D"cite"><br></blockquote></blockquote></blockquote><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"># =
requiretty<br></blockquote></blockquote></blockquote><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote =
type=3D"cite"><br></blockquote></blockquote></blockquote><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">instead =
of:<br></blockquote></blockquote></blockquote><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote =
type=3D"cite"><br></blockquote></blockquote></blockquote><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote =
type=3D"cite">requiretty<br></blockquote></blockquote></blockquote><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><blockquote =
type=3D"cite"><br></blockquote></blockquote></blockquote><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>It =
probably would be wise to preserve all leading and =
trailing<br></blockquote></blockquote></blockquote><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote =
type=3D"cite">characters for teardown to avoid inadvertently enabling =
requiretty<br></blockquote></blockquote></blockquote><blockquote =
type=3D"cite">in<br></blockquote><blockquote type=3D"cite"><blockquote =
type=3D"cite"><blockquote =
type=3D"cite">sudo.<br></blockquote></blockquote></blockquote><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>The EXIT =
trap handler isn't 100% foolproof, but it =
protects<br></blockquote></blockquote></blockquote><blockquote =
type=3D"cite">against<br></blockquote><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">all =
but SIGKILL or SIGSTOP from being executed as they're =
NMIs.</blockquote></blockquote></blockquote></div></blockquote><br></div><=
div>Thanks,</div><div>-Garrett</div></body></html>=

--Apple-Mail-1--77768631--


--===============6304003538000952878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============6304003538000952878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6304003538000952878==--

