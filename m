From: Tom Gall <tom.gall@linaro.org>
Date: Mon, 20 Nov 2017 10:48:58 -0600
Subject: [LTP] Towards 4.14 LTS
In-Reply-To: <20171120161029.GA2188@rei>
References: <5E1947BC-9D22-42EB-BA29-96EA15A9C817@linaro.org>
 <20171120161029.GA2188@rei>
Message-ID: <AD4F87EA-602A-402D-8E72-4DFB52585A5D@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it



> On Nov 20, 2017, at 10:10 AM, Cyril Hrubis <chrubis@suse.cz> wrote:
>=20
> Hi!
>> So why didn???t we report these? As mentioned we???ve been tossing out d=
odgy
>> test cases to get to a clean baseline. We don???t need or want noise.=20
>>=20
>> For LTS, I want the system when it detects a failure to enable a quick=20
>> bisect involving the affected test bucket. Given the nature of kernel=20
>> bugs tho, there is that class of bug which only happens occasionally.
>=20
> From my experience debugging kernel bugs requires an actuall human
> interaction and there is only certain level of automation that can be
> achieved. Don't take me wrong, automatic bisection and other bells and
> whistles are a nice to have, but at the end of the day you usually need
> someone to reproduce/look at the problem, possibly check the source
> code, report a bug, etc. Hence it does not make much sense to have an
> automated system without dedicated engineers assigned to review the test
> results.

You are entirely right automation only gets so far. We have a few lines
of defense that probably are worth a mention.

1) infra - sometimes results/runs need to be re-run for whatever reason.
2) triage - Crappy test case or something that is real?
3) kernel - bisecting etc

We don=E2=80=99t have huge dedicated teams for each category but likewise e=
ach=20
has a team.

> --=20
> Cyril Hrubis
> chrubis@suse.cz

