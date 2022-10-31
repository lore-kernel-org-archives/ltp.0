Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E93FA3741
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 19:25:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D45E3CAC23
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 20:25:51 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50A233C2A0E
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 20:25:37 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B87DE1A007FD
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 20:25:35 +0100 (CET)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VJCCkH017406;
 Mon, 31 Oct 2022 19:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=ejDxk11vYiP/iGlIQSQHTaT5NgrkqSrWN4frZqFv2cQ=;
 b=CexNNa+bWHzAWefbycdFqZZb7KHvzrBUA/DK84lmxV7m8jOOGhmdRbM8SXnnVcEhvDFx
 dZ0SuiCdAIKPFW+TfAKcqOkeUE8NkJAKOp8uwXu27+suEoQVIpOFdRtMFJE/hpVhSOp4
 1I7uob/BPMTNerieDZG9J4Y0qDtEnYp01WYo4I3QrX+fx4VLEqiUv8QaxQDwh1A+04g6
 Kf43ZSkJlWC2DimavyNHhaZE/Z1891BepbXAuzVLfahFAd7v3QYoznAegWhQwPTmutSK
 Gr5PF4myRrr6SSyeqiWouxM+8RH5T5vXhQgUmcoGfzG/eVbxmOiRYQjaZrgzeQ10Uo84 Yw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjmaa8d0h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Oct 2022 19:25:33 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29VJMieS008692;
 Mon, 31 Oct 2022 19:25:30 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma06fra.de.ibm.com with ESMTP id 3kguejajnc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Oct 2022 19:25:30 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 29VJQ3Ck49021196
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Oct 2022 19:26:03 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BFA242042;
 Mon, 31 Oct 2022 19:25:27 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B728B4203F;
 Mon, 31 Oct 2022 19:25:23 +0000 (GMT)
Received: from tarunpc (unknown [9.43.72.21])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon, 31 Oct 2022 19:25:23 +0000 (GMT)
Date: Tue, 1 Nov 2022 00:55:19 +0530
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20221031192519.x2exs2pfumpxe4zj@tarunpc>
References: <20221029071344.45447-1-tsahu@linux.ibm.com>
 <20221029071344.45447-2-tsahu@linux.ibm.com>
 <Y1/f5Uar5lB3lz0E@yuki>
Content-Disposition: inline
In-Reply-To: <Y1/f5Uar5lB3lz0E@yuki>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sV7qM0nadGZoHAgXdax40oQ22pPd46KR
X-Proofpoint-ORIG-GUID: sV7qM0nadGZoHAgXdax40oQ22pPd46KR
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_19,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210310118
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] Hugetlb: Add new tst_test options for
 hugeltb test support
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: aneesh.kumar@linux.ibm.com, ltp@lists.linux.it, geetika@linux.ibm.com,
 sbhat@linux.ibm.com, vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Oct 31 2022, Cyril Hrubis wrote:
> Hi!
> >  extern unsigned int tst_variant;
> > -
> > +extern int tst_hugetlb_fd;
> >  #define TST_NO_HUGEPAGES ((unsigned long)-1)
> >  
> >  #define TST_UNLIMITED_RUNTIME (-1)
> > @@ -176,6 +176,18 @@ struct tst_test {
> >  	int all_filesystems:1;
> >  	int skip_in_lockdown:1;
> >  	int skip_in_compat:1;
> > +	/*
> > +	 * If set, the test function will create a hugetlbfs mount point
> > +	 * at /tmp/xxxxxx, where xxxxxx is a random string.
> > +	 */
> > +	int needs_hugetlbfs:1;
> > +	/*
> > +	 * If set, the test function will create and open a random file
> > +	 * under mounted hugetlbfs. To use this option, needs_hugetlbfs must
> > +	 * be set. The file descriptior will be set in tst_hugetlb_fd.
> > +	 * The close(tst_hugetlb_fd) will be called on test exit(cleanup).
> > +	 */
> > +	int needs_unlinked_hugetlb_file:1;
> >  
> >  	/*
> >  	 * The skip_filesystems is a NULL terminated list of filesystems the
> > @@ -357,6 +369,12 @@ unsigned int tst_remaining_runtime(void);
> >   */
> >  void tst_set_max_runtime(int max_runtime);
> >  
> > +/*
> > + * Create and open a random file inside the given dir path.
> > + * It unlinks the file after opening and return file descriptor.
> > + */
> > +int tst_create_unlinked_file(const char *path);
> > +
> >  /*
> >   * Returns path to the test temporary directory in a newly allocated buffer.
> >   */
> > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > index 8ccde1629..43cba1004 100644
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -925,7 +925,8 @@ static int needs_tmpdir(void)
> >  	       tst_test->needs_device ||
> >  	       tst_test->mntpoint ||
> >  	       tst_test->resource_files ||
> > -	       tst_test->needs_checkpoints;
> > +	       tst_test->needs_checkpoints ||
> > +		   tst_test->needs_hugetlbfs;
> >  }
> >  
> >  static void copy_resources(void)
> > @@ -1021,6 +1022,30 @@ static void prepare_and_mount_dev_fs(const char *mntpoint)
> >  	}
> >  }
> >  
> > +static void prepare_and_mount_hugetlb_fs(void)
> > +{
> > +	tst_test->mntpoint = tst_get_tmpdir();
> > +	SAFE_MOUNT("none", tst_test->mntpoint, "hugetlbfs", 0, NULL);
> > +	mntpoint_mounted = 1;
> > +}
> > +
> > +int tst_create_unlinked_file(const char *path)
> > +{
> > +	char template[PATH_MAX];
> > +	int fd;
> > +
> > +	snprintf(template, PATH_MAX, "%s/ltp_%.3sXXXXXX",
> > +			path, TCID);
> > +
> > +	fd = mkstemp(template);
> > +	if (fd < 0)
> > +		tst_brk(TBROK | TERRNO,
> > +			 "%s: mkstemp(%s) failed", __func__, template);
> > +
> > +	SAFE_UNLINK(template);
> > +	return fd;
> > +}
> > +
> >  static const char *limit_tmpfs_mount_size(const char *mnt_data,
> >  		char *buf, size_t buf_size, const char *fs_type)
> >  {
> > @@ -1094,6 +1119,8 @@ static void do_cgroup_requires(void)
> >  	tst_cg_init();
> >  }
> >  
> > +int tst_hugetlb_fd = -1;
> > +
> >  static void do_setup(int argc, char *argv[])
> >  {
> >  	if (!tst_test)
> > @@ -1217,6 +1244,17 @@ static void do_setup(int argc, char *argv[])
> >  		}
> >  	}
> >  
> > +	if (tst_test->needs_hugetlbfs)
> > +		prepare_and_mount_hugetlb_fs();
> > +
> > +	if (tst_test->needs_unlinked_hugetlb_file) {
> > +		if (!(tst_test->needs_hugetlbfs)) {
> > +			tst_brk(TBROK, "Option needs_unlinked_hugetlb_file "
> > +					"requires option needs_hugetlbfs");
> > +		}
> > +		tst_hugetlb_fd = tst_create_unlinked_file(tst_test->mntpoint);
> > +	}
> 
> The function tst_create_unlinked_file() looks useful, but I do not think
> that adding the needs_unlinked_hugetlb_file flag simplifies things that
> much. Also this will not scale well when we would need two
> filedescripors like that. Maybe we it would be cleaner to add only the
> mount/umount functionality to the test library and call the
> tst_create_unlinked_file() in the test setup in the testcases.
> 
yes I agree, There is a test that requires two such unlinked file, 
there is one that requires one hugetlb and one normal such unlinked file.


> >  	if (tst_test->needs_device && !mntpoint_mounted) {
> >  		tdev.dev = tst_acquire_device_(NULL, tst_test->dev_min_size);
> >  
> > @@ -1299,8 +1337,15 @@ static void do_cleanup(void)
> >  	if (ovl_mounted)
> >  		SAFE_UMOUNT(OVL_MNT);
> >  
> > -	if (mntpoint_mounted)
> > -		tst_umount(tst_test->mntpoint);
> > +	if (tst_hugetlb_fd >= 0)
> > +		SAFE_CLOSE(tst_hugetlb_fd);
> > +
> > +	if (mntpoint_mounted) {
> > +		if (tst_test->needs_hugetlbfs)
> > +			SAFE_UMOUNT(tst_test->mntpoint);
> > +		else
> > +			tst_umount(tst_test->mntpoint);
> > +	}
> 
> Is there a good reason for this, why can't we call tst_umount() for
> hugetlbfs?
> 

My reason behind this is, 
tst_umount doesnt break the test, if umount fails. One of the cause
of failure can be that test left the mounted fs busy, which is not
expected.
> -- 
> Cyril Hrubis
> chrubis@suse.cz
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
