From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 21 Apr 2020 18:35:20 +0800
Subject: [LTP] [PATCH v2 02/10] syscalls/ioctl:add common c file for
 loop ioctl
In-Reply-To: <20200421085544.GB6577@yuki.lan>
References: <20200409075506.GA2828@yuki.lan>
 <1586429086-22975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1586429086-22975-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200417151050.GA2491@yuki.lan>
 <8dd0a496-c46f-55d2-2393-5566eff618ff@cn.fujitsu.com>
 <48142e6b-8169-2934-e8b2-f71927cd62b0@cn.fujitsu.com>
 <20200420130140.GB11604@yuki.lan>
 <d3063175-5014-51ea-9d1c-4a9f3e2243b1@cn.fujitsu.com>
 <20200421085544.GB6577@yuki.lan>
Message-ID: <4b8ee0d5-6f5d-be72-a49a-6cfe3d13e06a@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril


> Hi!
>>>> +void tst_assert_file_str(const char *file, const int lineno, const char
>>>> *path, const char *buf, const char *val)
>>>> +{
>>>> +       char sys_val[1024];
>>>> +
>>>> +       SAFE_FILE_LINES_SCANF(path, buf, sys_val);
>>>
>>> We should call the file_lines_scanf() here and pass the filename and
>>> lineno that this functions takes as parameter instead.
>> I don't understand the meaning of adding filename and line parameter(If
>> fail, it will report tst_assert.c: 29). Do you want to report the
>> correct parsed filename when failed?
>>
>> If so, I think lineno is meaningless and it also overides the place of
>> the code meet problem . I prefer to add some path info in safe_file_ops.c.
> 
> What I want is to show the test source filename and line on failure, for
> that we have to pass the lineno and file to the file_lines_scanf()
> function. I think that it makes much more sense to print the line in a
> test where the problem has happened rather than some location in the
> library code.
Oh, I see. ie TST_ASSERT_INT, modify ioctl_loop01.c
TST_ASSERT_INT(__FILE__, __LINE__, partscan_path, 0);
if partscan_path doesn't exist, it will report error as below:
safe_file_ops.c:142: BROK: Failed to open FILE 
'/sys/block/loop0/loop1/partscan' for reading at ioctl_loop01.c:46: 
ENOENT (2)

--- a/lib/tst_assert.c
+++ b/lib/tst_assert.c
-void tst_assert_int(const char *file, const int lineno, const char 
*path, int val)
+void tst_assert_int(const char *file, const int lineno, const char 
*source_path,
+                   const int source_pos, const char *path, int val)
  {
         int sys_val;

-       SAFE_FILE_SCANF(path, "%d", &sys_val);
+       safe_file_scanf(source_path, source_pos, NULL, path, "%d", &sys_val

diff --git a/include/tst_assert.h b/include/tst_assert.h
index 913fff1b5..03e57bbd9 100644
--- a/include/tst_assert.h
+++ b/include/tst_assert.h
@@ -7,8 +7,8 @@
  #ifndef TST_ASSERT_H__
  #define TST_ASSERT_H__

-#define TST_ASSERT_INT(path, val) \
-       tst_assert_int(__FILE__, __LINE__, path, val)
+#define TST_ASSERT_INT(source_path, source_pos, path, val) \
+       tst_assert_int(__FILE__, __LINE__, source_path, source_pos, 
path, val)

  /*
   * Asserts that integer value stored in file pointed by path equals to the
@@ -16,6 +16,7 @@
   * values in sysfs, procfs, etc.
   */
  void tst_assert_int(const char *file, const int lineno,
+                   const char *source_path, const int source_pos,
                     const char *path, int val);

  #define TST_ASSERT_FILE_INT(path, buf, val)

> 


