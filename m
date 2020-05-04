From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 4 May 2020 14:33:53 +0200
Subject: [LTP] [PATCH v2 4/4] syscalls/fanotify: Use fanotify_save_fid()
 helper
In-Reply-To: <20200502162744.9589-5-amir73il@gmail.com>
References: <20200502162744.9589-1-amir73il@gmail.com>
 <20200502162744.9589-5-amir73il@gmail.com>
Message-ID: <20200504123353.GA14280@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> Reduce some boiler plate code in FAN_REPORT_FID tests and
> save fid only once per object instead of once per expected event.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
+1

>  static int setup_marks(unsigned int fd, struct test_case_t *tc)
> @@ -130,8 +125,8 @@ static int setup_marks(unsigned int fd, struct test_case_t *tc)
>  					"kernel");
>  				return 1;
>  			} else if (errno == ENODEV &&
> -					!event_set[i].fsid.val[0] &&
> -					!event_set[i].fsid.val[1]) {
> +				   !FSID_VAL_MEMBER(objects[i].fid.fsid, 0) &&
> +				   !FSID_VAL_MEMBER(objects[i].fid.fsid, 1)) {

For the same reasons as the previous commits this diff is needed:
-				   !FSID_VAL_MEMBER(objects[i].fid.fsid, 0) &&
-				   !FSID_VAL_MEMBER(objects[i].fid.fsid, 1)) {
+				   !objects[i].fid.fsid.val[0] &&
+				   !objects[i].fid.fsid.val[1]) {


Kind regards,
Petr
