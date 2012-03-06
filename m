Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1S4veU-0003Py-43
	for ltp-list@lists.sourceforge.net; Tue, 06 Mar 2012 14:46:10 +0000
Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S4veO-00011d-N7
	for ltp-list@lists.sourceforge.net; Tue, 06 Mar 2012 14:46:10 +0000
Received: by obqv19 with SMTP id v19so8261190obq.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 06 Mar 2012 06:45:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1331029739-32353-1-git-send-email-markos.chandras@imgtec.com>
References: <1331029739-32353-1-git-send-email-markos.chandras@imgtec.com>
Date: Tue, 6 Mar 2012 06:45:59 -0800
Message-ID: <CAGH67wTM0b+USqri2yCpUOcnKi2ma7OamuOM81dRP5YGCm6poA@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] runltp: Remove excess quotes from final message
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
To: Markos Chandras <markos.chandras@imgtec.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Mar 6, 2012 at 2:28 AM, Markos Chandras
<markos.chandras@imgtec.com> wrote:
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
> =A0runltp | =A0 =A06 +++---
> =A01 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/runltp b/runltp
> index 4ef8b38..fc3515b 100755
> --- a/runltp
> +++ b/runltp
> @@ -948,11 +948,11 @@ main()
> =A0 =A0 {
> =A0 =A0 cat <<-EOF >&1
>
> - =A0 =A0 =A0 ###########################################################=
####"
> + =A0 =A0 =A0 ###########################################################=
####
>
> - =A0 =A0 =A0 =A0 =A0 =A0Done executing testcases."
> + =A0 =A0 =A0 =A0 =A0 =A0Done executing testcases.
> =A0 =A0 =A0 =A0 =A0 =A0 LTP Version: =A0$version_date
> - =A0 =A0 =A0 ###########################################################=
####"
> + =A0 =A0 =A0 ###########################################################=
####
>
> =A0 =A0 =A0 =A0EOF
> =A0 =A0 }

Reviewed-by: Garrett Cooper <yanegomi@gmail.com>

---------------------------------------------------------------------------=
---
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
