From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 30 Jul 2019 18:42:10 +0800
Subject: [LTP] [PATCH v6 1/3] lib: alter find_free_loopdev()
In-Reply-To: <20190729130107.GA27006@rei.lan>
References: <5D30200B.4050306@cn.fujitsu.com>
 <1564030915-3211-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190729130107.GA27006@rei.lan>
Message-ID: <5D401F02.5080209@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


> Hi!
>> +int tst_find_free_loopdev(const char *path, size_t path_len);
>>   /*
>>    * Reads test block device stat file and returns the bytes written since the
>>    * last call of this function.
>> diff --git a/lib/tst_device.c b/lib/tst_device.c
>> index 65fcc1337..f2516fb08 100644
>> --- a/lib/tst_device.c
>> +++ b/lib/tst_device.c
>> @@ -53,22 +53,22 @@ static const char *dev_variants[] = {
>>   	"/dev/block/loop%i"
>>   };
>>
>> -static int set_dev_path(int dev)
>> +static int set_dev_path(int dev, char *path, size_t path_len)
>>   {
>>   	unsigned int i;
>>   	struct stat st;
>>
>>   	for (i = 0; i<  ARRAY_SIZE(dev_variants); i++) {
>> -		snprintf(dev_path, sizeof(dev_path), dev_variants[i], dev);
>> +		snprintf(path, path_len, dev_variants[i], dev);
>>
>> -		if (stat(dev_path,&st) == 0&&  S_ISBLK(st.st_mode))
>> +		if (stat(path,&st) == 0&&  S_ISBLK(st.st_mode))
>>   			return 1;
>>   	}
>>
>>   	return 0;
>>   }
>>
>> -static int find_free_loopdev(void)
>> +int tst_find_free_loopdev(char *path, size_t path_len)
>>   {
>>   	int ctl_fd, dev_fd, rc, i;
>>   	struct loop_info loopinfo;
>> @@ -80,12 +80,14 @@ static int find_free_loopdev(void)
>>   		rc = ioctl(ctl_fd, LOOP_CTL_GET_FREE);
>>   		close(ctl_fd);
>>   		if (rc>= 0) {
>> -			set_dev_path(rc);
>> -			tst_resm(TINFO, "Found free device '%s'", dev_path);
>> -			return 0;
>> +			if (path)
>> +				set_dev_path(rc, path, path_len);
>> +			tst_resm(TINFO, "Found free device %d '%s'",
>> +				rc, path ?: "");
>> +			return rc;
>>   		}
>>   		tst_resm(TINFO, "Couldn't find free loop device");
>> -		return 1;
>> +		return -1;
>>   	}
>>
>>   	switch (errno) {
>> @@ -104,24 +106,24 @@ static int find_free_loopdev(void)
>>   	 * Older way is to iterate over /dev/loop%i and /dev/loop/%i and try
>>   	 * LOOP_GET_STATUS ioctl() which fails for free loop devices.
>>   	 */
>> -	for (i = 0; i<  256; i++) {
>> +	for (i = 0; path&&  i<  256; i++) {
> There is still a small problem here in the fallback code for older
> kernels. The way we detect a free device there is by opening the device
> and doing the LOOP_GET_STATUS ioctl(). So by disabling this loop if path
> is not set we broke the detection on older kernels when NULL is passed
> to the function.
>
> We should work with a local temporary path in this loop and copy it over
> to the path if we are succesfull and if path is not NULL.
>
Hi Cyril

Thanks for pointing out it.  I will fix it on next version. as below:

int tst_find_free_loopdev(char *path, size_t path_len)
  {
         int ctl_fd, dev_fd, rc, i;
         struct loop_info loopinfo;
+       char buf[1024];

         /* since Linux 3.1 */
         ctl_fd = open(LOOP_CONTROL_FILE, O_RDWR);
@@ -80,12 +81,14 @@ static int find_free_loopdev(void)
                 rc = ioctl(ctl_fd, LOOP_CTL_GET_FREE);
                 close(ctl_fd);
                 if (rc>= 0) {
-                       set_dev_path(rc);
-                       tst_resm(TINFO, "Found free device '%s'", dev_path);
-                       return 0;
+                       if (path)
+                               set_dev_path(rc, path, path_len);
+                       tst_resm(TINFO, "Found free device %d '%s'",
+                               rc, path ?: "");
+                       return rc;
                 }
                 tst_resm(TINFO, "Couldn't find free loop device");
-               return 1;
+               return -1;
         }


  static int find_free_loopdev(void)
          */
         for (i = 0; i<  256; i++) {

-               if (!set_dev_path(i))
+               if (!set_dev_path(i, buf, sizeof(buf)))
                         continue;

-               dev_fd = open(dev_path, O_RDONLY);
+               dev_fd = open(buf, O_RDONLY);

                 if (dev_fd<  0)
                         continue;

                 if (ioctl(dev_fd, LOOP_GET_STATUS,&loopinfo) == 0) {
-                       tst_resm(TINFO, "Device '%s' in use", dev_path);
+                       tst_resm(TINFO, "Device '%s' in use", buf);
                 } else {
                         if (errno != ENXIO)
                                 continue;
-                       tst_resm(TINFO, "Found free device '%s'", dev_path);
+                       tst_resm(TINFO, "Found free device '%s'", buf);
                         close(dev_fd);
-                       return 0;
+                       if (path != NULL)
+                               strcpy(path, buf);
+                       return i;
                 }


Thanks
Yang Xu

>> -		if (!set_dev_path(i))
>> +		if (!set_dev_path(i, path, path_len))
>>   			continue;
>>
>> -		dev_fd = open(dev_path, O_RDONLY);
>> +		dev_fd = open(path, O_RDONLY);
>>
>>   		if (dev_fd<  0)
>>   			continue;
>>
>>   		if (ioctl(dev_fd, LOOP_GET_STATUS,&loopinfo) == 0) {
>> -			tst_resm(TINFO, "Device '%s' in use", dev_path);
>> +			tst_resm(TINFO, "Device '%s' in use", path);
>>   		} else {
>>   			if (errno != ENXIO)
>>   				continue;
>> -			tst_resm(TINFO, "Found free device '%s'", dev_path);
>> +			tst_resm(TINFO, "Found free device '%s'", path);
>>   			close(dev_fd);
>> -			return 0;
>> +			return i;
>>   		}
>>
>>   		close(dev_fd);
>> @@ -129,7 +131,7 @@ static int find_free_loopdev(void)
>>
>>   	tst_resm(TINFO, "No free devices found");
>>
>> -	return 1;
>> +	return -1;
>>   }



