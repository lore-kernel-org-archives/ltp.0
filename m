Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1Q8R3v-0002dZ-6i
	for ltp-list@lists.sourceforge.net; Sat, 09 Apr 2011 05:50:23 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Q8R3u-0003hQ-BW
	for ltp-list@lists.sourceforge.net; Sat, 09 Apr 2011 05:50:23 +0000
Received: by pwj9 with SMTP id 9so2235824pwj.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 08 Apr 2011 22:50:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <57c873600371b0d63d046e940cea750c2e70618a.1302294850.git.aelder@sgi.com>
References: <2fb6f8d9dc82ef63e3c7cd80151cb6ea7972aae9.1302294850.git.aelder@sgi.com>
	<1302294875-6898-1-git-send-email-aelder@sgi.com>
	<57c873600371b0d63d046e940cea750c2e70618a.1302294850.git.aelder@sgi.com>
Date: Fri, 8 Apr 2011 22:50:16 -0700
Message-ID: <BANLkTik8D_BwKKpnQfqEsYMn_8inPB83Hg@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 3/4] ltp: kill warnings related to formatting
 off_t in "aio-stress.c"
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
To: Alex Elder <aelder@sgi.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, Apr 8, 2011 at 1:34 PM, Alex Elder <aelder@sgi.com> wrote:
> In "testcases/kernel/io/ltp-aiodio/aio-stress.c" there are a number
> of warnings that show up due to mismatches between fprintf()
> conversion specifications and the variables being formatted.
>
> Fix most of these by casting the variables to the right type; in one
> case a "%td" is used to signify a ptrdiff_t variable.
>
> Signed-off-by: Alex Elder <aelder@sgi.com>
> ---
> =A0testcases/kernel/io/ltp-aiodio/aio-stress.c | =A0 18 +++++++++++-------
> =A01 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/testcases/kernel/io/ltp-aiodio/aio-stress.c b/testcases/kern=
el/io/ltp-aiodio/aio-stress.c
> index e77f5be..cd0b211 100644
> --- a/testcases/kernel/io/ltp-aiodio/aio-stress.c
> +++ b/testcases/kernel/io/ltp-aiodio/aio-stress.c
> @@ -1165,7 +1165,7 @@ restart:
>
> =A0 =A0 if (t->stage_mb_trans && t->num_files > 0) {
> =A0 =A0 =A0 =A0 double seconds =3D time_since_now(&stage_time);
> - =A0 =A0 =A0 fprintf(stderr, "thread %d %s totals (%.2f MB/s) %.2f MB in=
 %.2fs\n",
> + =A0 =A0 =A0 fprintf(stderr, "thread %td %s totals (%.2f MB/s) %.2f MB i=
n %.2fs\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0t - global_thread_info, this_stage, t->sta=
ge_mb_trans/seconds,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0t->stage_mb_trans, seconds);
> =A0 =A0 }
> @@ -1447,16 +1447,20 @@ int main(int ac, char **av)
>
> =A0 =A0 if (file_size < num_contexts * context_offset) {
> =A0 =A0 =A0 =A0 fprintf(stderr, "file size %Lu too small for %d contexts\=
n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 file_size, num_contexts);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long) file_size, num_context=
s);

file_size should really be size_t and the format qualifier should be %zu.

> =A0 =A0 =A0 =A0exit(1);
> =A0 =A0 }
>
> - =A0 =A0fprintf(stderr, "file size %LuMB, record size %luKB, depth %d, i=
os per iteration %d\n", file_size / (1024 * 1024), rec_len / 1024, depth, i=
o_iter);
> + =A0 =A0fprintf(stderr, "file size %LuMB, record size %luKB, depth %d, "
> + =A0 =A0 =A0 =A0 =A0 "ios per iteration %d\n",

ios is a product made by Cisco. "I/O per iteration" makes more sense here.

> + =A0 =A0 =A0 =A0 =A0 (unsigned long long) (file_size / (1024 * 1024)),
> + =A0 =A0 =A0 =A0 =A0 rec_len / 1024, depth, io_iter);

Same as above.

> =A0 =A0 fprintf(stderr, "max io_submit %d, buffer alignment set to %luKB\=
n",
> =A0 =A0 =A0 =A0 =A0 =A0 max_io_submit, (page_size_mask + 1)/1024);
> - =A0 =A0fprintf(stderr, "threads %d files %d contexts %d context offset =
%LuMB verification %s\n",
> - =A0 =A0 =A0 =A0 =A0 =A0num_threads, num_files, num_contexts,
> - =A0 =A0 =A0 =A0 =A0 context_offset / (1024 * 1024), verify ? "on" : "of=
f");
> + =A0 =A0fprintf(stderr, "threads %d files %d contexts %d context offset =
%LuMB "
> + =A0 =A0 =A0 =A0 =A0 "verification %s\n", num_threads, num_files, num_co=
ntexts,
> + =A0 =A0 =A0 =A0 =A0 (unsigned long long) context_offset / (1024 * 1024),

context_offset should be size_t too.

> + =A0 =A0 =A0 =A0 =A0 verify ? "on" : "off");

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
